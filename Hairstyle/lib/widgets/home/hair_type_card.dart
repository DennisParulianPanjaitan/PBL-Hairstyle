import 'package:flutter/material.dart';

class HairTypeCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final double size; // Parameter size untuk mengatur lebar dan tinggi sekaligus

  // Konstruktor dengan parameter size
  HairTypeCard({
    required this.imagePath,
    required this.label,
    this.size = 100, // Nilai default untuk ukuran
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, // Menggunakan parameter size untuk lebar
      height: size, // Menggunakan parameter size untuk tinggi
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand, // Menyesuaikan ukuran stack dengan container
        children: [
          // Gambar di belakang
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: size, // Menggunakan parameter size untuk lebar gambar
              height: size, // Menggunakan parameter size untuk tinggi gambar
              fit: BoxFit.cover,
            ),
          ),
          // Teks di depan gambar
          Positioned(
            bottom: 0, // Posisi teks di bagian bawah gambar
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Warna teks putih agar terlihat jelas
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
