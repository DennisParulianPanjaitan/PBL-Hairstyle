import 'package:flutter/material.dart';

import '../widgets/image_slider.dart';


class DetailHaircut extends StatelessWidget {
  final String title;
  final String description;
  final List<String> sliderImages;
  final List<String> galleryImages;
  final List<String> faceShapes;

  const DetailHaircut({
    Key? key,
    required this.title,
    required this.description,
      required this.sliderImages,
      required this.galleryImages,
    required this.faceShapes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Slider menggunakan sliderImages
                  ImageSlider(images: sliderImages),
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
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xFF1B1A55),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     const Icon(Icons.star, color: Colors.amber, size: 20),
                            //     const SizedBox(width: 4),
                            //     const Text(
                            //       "4.5",
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Face Shape",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1A55),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: faceShapes.map(_buildFaceTag).toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1A55),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Galeri menggunakan galleryImages
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14.0,
                            mainAxisSpacing: 14.0,
                          ),
                          itemCount: galleryImages.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                galleryImages[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: Image.asset(
                  'assets/icons/detailarrow.png',
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1B1A55)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1B1A55),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


