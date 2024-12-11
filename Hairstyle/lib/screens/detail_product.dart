import 'package:flutter/material.dart';

import '../widgets/image_slider.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/pomade.jpeg',
      'assets/images/pomade1.jpg',
      'assets/images/pomade2.jpg',
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menggunakan ImageSlider sebagai pengganti gambar
                  ImageSlider(images: images),
                  const SizedBox(height: 16),
                  // Informasi haircut
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Buzz Cut",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xFF1B1A55),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  "4.5",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "A buzz cut is a short and neat hairstyle, typically achieved using electric clippers set to a low guard number, usually between 1 and 3. This style results in hair being cropped close to the scalp, leaving only a small amount of length.",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                          children: [
                            // Menambahkan gambar di awal (sebelah kiri)
                            Image.asset(
                              'assets/icons/beared.png', // Ganti dengan path gambar Anda
                              width: 40, // Sesuaikan ukuran gambar
                              height: 40, // Sesuaikan ukuran gambar
                            ),
                            _buildFaceTag("Diamond"),
                            _buildFaceTag("Square"),
                            _buildFaceTag("Oval"),
                          ],
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
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14.0,
                            mainAxisSpacing: 14.0,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                'assets/images/haircut_gallery_$index.jpeg',
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
            // Tombol Back menggunakan Positioned
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: Image.asset(
                  'assets/icons/detailarrow.png', // Ganti dengan path gambar Anda
                  width: 30, // Sesuaikan ukuran gambar sesuai kebutuhan
                  height: 30, // Sesuaikan ukuran gambar sesuai kebutuhan
                ),
                onPressed: () {
                  Navigator.pop(
                      context); // Fungsi untuk kembali ke layar sebelumnya
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk face tag
  Widget _buildFaceTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 2), // Ubah vertical menjadi 4
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
