import 'package:flutter/material.dart';

class PopularHairstyleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  PopularHairstyleCard({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // Menentukan ukuran gambar berdasarkan title
    double imageWidth = 180;
    double imageHeight = 180;

    if (title == "Buzz Cut") {
      imageWidth = 200; // Lebar gambar berbeda untuk Buzz Cut
      imageHeight = 220; // Tinggi gambar berbeda untuk Buzz Cut
    } else if (title == "Coma") {
      imageWidth = 0; // Lebar gambar berbeda untuk Coma
      imageHeight = 100; // Tinggi gambar berbeda untuk Coma
    } else if (title == "Undercut") {
      imageWidth = 180; // Lebar gambar berbeda untuk Undercut
      imageHeight = 200; // Tinggi gambar berbeda untuk Undercut
    } else if (title == "Mullet") {
      imageWidth = 190; // Lebar gambar berbeda untuk Mullet
      imageHeight = 210; // Tinggi gambar berbeda untuk Mullet
    } else if (title == "Two Block") {
      imageWidth = 220; // Lebar gambar berbeda untuk Two Block
      imageHeight = 240; // Tinggi gambar berbeda untuk Two Block
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Color(0xFF1B1A55),
        elevation: 10, // Efek bayangan
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom pertama untuk gambar dengan ukuran tetap
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 120, // Tentukan lebar gambar tetap (misalnya 100)
                  height: 200, // Tentukan tinggi gambar tetap
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16), // Jarak antar kolom
              // Kolom kedua untuk title dan description, menggunakan Expanded agar kolom teks mengambil sisa ruang
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
