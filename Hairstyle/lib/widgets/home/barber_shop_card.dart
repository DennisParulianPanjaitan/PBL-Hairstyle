import 'package:flutter/material.dart';

class BarberShopCard extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final String imagePath;

  BarberShopCard({
    required this.name,
    required this.price,
    required this.rating,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Warna shadow
            spreadRadius: 2, // Jarak shadow dari elemen
            blurRadius: 10, // Menentukan seberapa kabur shadow
            offset: Offset(0, 4), // Posisi shadow (horizontal, vertical)
          ),
        ],
      ),
      child: Stack(
        children: [
          // Gambar latar belakang
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 180, // Mengatur tinggi gambar latar belakang
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Teks dan informasi di depan gambar
          Positioned(
            left: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Bintang dan rating di pojok kanan bawah
          Positioned(
            right: 12, // Menempatkan di pojok kanan
            bottom: 12, // Menempatkan di bawah
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
