import 'package:flutter/material.dart';

class BarberShopCardfeature extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final String imagePath;

  BarberShopCardfeature({
    required this.name,
    required this.price,
    required this.rating,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6), // Mengurangi jarak menjadi 6 pixel
      width: MediaQuery.of(context).size.width *
          0.7, // Menyesuaikan 70% dari lebar layar
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Radius sudut tetap
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
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
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Teks dan informasi di depan gambar
          Positioned(
            left: 0, // Mengatur posisi mulai dari paling kiri
            right: 0, // Membuat container memenuhi lebar layar
            bottom: 0, // Posisi di bawah
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 8, vertical: 12), // Padding atas dan bawah
              decoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(0.100), // Background hitam transparan
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),

// Bintang dan rating di pojok kanan bawah
          Positioned(
            left: 0, // Membuat latar memenuhi dari sisi kiri
            right: 0, // Membuat latar memenuhi sampai sisi kanan
            bottom: 0, // Tetap di bagian bawah
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12), // Padding atas-bawah lebih besar
              decoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(0.5), // Background hitam transparan
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Menyebar teks dan rating ke kiri dan kanan
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        price,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 10),
                      SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
