import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_linkaja/widgets/hair_button.dart';

class RecommendationScreen extends StatefulWidget {
  final dynamic result;
  final String imagePath;

  // const RecommendationScreen({super.key});
  const RecommendationScreen({
    super.key,
    required this.result,
    required this.imagePath,
  });

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int _currentIndex = 0;
  List<dynamic> recommendations = [];
  bool isLoading = true;
  bool isFetching = false;
  late int id;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('id') ?? 0; // Ambil user_id, default 0 jika null

    if (id == 0) {
      print("Error: user_id not found in SharedPreferences.");
      return;
    }

    fetchRecommendations(widget.result['predicted_class']);
  }

  /// Fungsi untuk fetch data rekomendasi dari API
  Future<void> fetchRecommendations(String predictedClass) async {
    print(
        'Predicted Class: $predictedClass'); // Debugging nilai predicted_class

    final url = Uri.parse('https://hairmate.smartrw.my.id/api/recommendation');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'face_shape': predictedClass}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('API Response: ${response.body}');

        if (responseData['success']) {
          setState(() {
            widget.result['description'] = responseData['data']['description'];
            recommendations = responseData['data']['hairstyles'];
            isLoading = false;
          });

          // Simpan ke scan_history
          await saveScanHistory(
            widget.imagePath,
            predictedClass,
            responseData['data']['id'], // ID rekomendasi
          );
        } else {
          setState(() {
            recommendations = [];
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to fetch recommendations');
      }
    } catch (error) {
      print('Error fetching recommendations: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Fungsi untuk menyimpan hasil scan ke database scan_history
  Future<void> saveScanHistory(
      String filePath, String faceShape, int recomId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    if (userId == 0) {
      print("Error: user_id not found in SharedPreferences.");
      return;
    }

    final url =
        Uri.parse('https://hairmate.smartrw.my.id/api/scan-history/store');

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = userId.toString()
        ..fields['face_shape'] = faceShape
        ..fields['recom_id'] = recomId.toString()
        ..files.add(await http.MultipartFile.fromPath('image', filePath));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(responseData);
        if (decodedResponse['success']) {
          print('Scan history saved successfully!');
        } else {
          print('Failed to save scan history: ${decodedResponse['message']}');
        }
      } else {
        print('Error saving scan history: ${response.statusCode}');
      }
    } catch (error) {
      print('Error saving scan history: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String capitalize(String text) {
      if (text.isEmpty) return '';
      return text[0].toUpperCase() + text.substring(1).toLowerCase();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.file(
                      File(widget.imagePath),
                      width: double.infinity,
                      // height: 550,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          capitalize(
                              widget.result['predicted_class'] ?? 'No Data'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xFF1B1A55),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.result['description'] ??
                          "No description available",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Recommendation hairstyle",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B1A55),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(recommendations.length, (index) {
                        final hairstyle = recommendations[index];
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.0), // Spasi antar tombol
                            child: HairButton(
                              label: hairstyle['name'],
                              isSelected: _currentIndex == index,
                              onTap: () {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    IndexedStack(
                      index: _currentIndex,
                      children: List.generate(recommendations.length, (index) {
                        return _buildCut(index);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCut(int index) {
    final hairstyle = recommendations[index];
    final images = hairstyle['images'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hairstyle['description'] ?? 'Description not available',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        Text(
          "Gallery",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B1A55),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: images.length,
          itemBuilder: (context, imgIndex) {
            final String imageUrl = images[imgIndex]['image_url'] ?? '';
            final String assetPath = 'assets/images/$imageUrl';

            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                assetPath, // Tambahkan path lokal
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
