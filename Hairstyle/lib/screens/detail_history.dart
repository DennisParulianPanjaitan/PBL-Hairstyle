import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:uts_linkaja/widgets/hair_button.dart'; // Pastikan widget ini sudah tersedia

class DetailHistoryScreen extends StatefulWidget {
  final String scanId;

  const DetailHistoryScreen({super.key, required this.scanId});

  @override
  _DetailHistoryScreenState createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  bool isLoading = true; // Loading state
  int _currentIndex = 0; // Index hairstyle aktif
  Map<String, dynamic> historyDetail = {}; // Data detail history
  List<dynamic> hairstyles = []; // List hairstyles

  @override
  void initState() {
    super.initState();
    fetchDetailHistory();
  }

  /// Fungsi untuk fetch data detail history berdasarkan scan_id
  Future<void> fetchDetailHistory() async {
    final url =
        Uri.parse('https://hairmate.smartrw.my.id/api/scan-history/detail');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'scan_id': widget.scanId}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          setState(() {
            historyDetail = responseData['data'];
            hairstyles = historyDetail['hairstyles'] ?? [];
            isLoading = false;
          });
        } else {
          print('Error: ${responseData['message']}');
          setState(() => isLoading = false);
        }
      } else {
        print('Error: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (error) {
      print('Error fetching history: $error');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String capitalize(String text) {
      if (text.isEmpty) return 'No Face Shape';
      return text[0].toUpperCase() + text.substring(1).toLowerCase();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail History',
          style: TextStyle(color: Color(0xFF1B1A55)),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF1B1A55)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar scan yang disimpan
                  Image.network(
                    historyDetail['scan_image'] ?? '',
                    width: double.infinity,
                    // height: 250,
                    fit: BoxFit.fill,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Face Shape
                        Text(
                          capitalize(
                              historyDetail['face_shape'] ?? 'No Face Shape'),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1A55),
                          ),
                        ),

                        const SizedBox(height: 8),
                        // Deskripsi
                        Text(
                          historyDetail['description'] ??
                              'No description available',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        // Recommended Hairstyles
                        const Text(
                          "Recommended Hairstyles",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1A55),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Buttons untuk hairstyles
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(hairstyles.length, (index) {
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: HairButton(
                                  label: hairstyles[index]['name'] ?? '',
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
                        // IndexedStack untuk deskripsi dan gallery
                        IndexedStack(
                          index: _currentIndex,
                          children: List.generate(hairstyles.length, (index) {
                            return _buildHaircutDetails(index);
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  /// Widget untuk menampilkan detail haircut berdasarkan index
  Widget _buildHaircutDetails(int index) {
    final hairstyle = hairstyles[index];
    final images = hairstyle['images'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hairstyle['description'] ?? 'No description available',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        const Text(
          "Gallery",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B1A55),
          ),
        ),
        const SizedBox(height: 8),
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

            // Menentukan path asset jika berasal dari lokal
            final String assetPath = 'assets/images/$imageUrl';

            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                assetPath, // Tambahkan prefix assets/images/
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
