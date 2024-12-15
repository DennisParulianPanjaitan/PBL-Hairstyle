import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    if (!isFetching) {
      isFetching = true; // Set flag ke true agar tidak dipanggil lagi
      fetchRecommendations(widget.result['predicted_class']);
    }
  }

  Future<void> fetchRecommendations(String predictedClass) async {
    print('Predicted Class: $predictedClass'); // Debug nilai predicted_class

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

  @override
  Widget build(BuildContext context) {
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
                          '${widget.result['predicted_class']}',
                          style: TextStyle(
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
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: hairstyle['images'].length,
          itemBuilder: (context, imgIndex) {
            final image = hairstyle['images'][imgIndex];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image['image_url'],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ],
    );
  }
}
