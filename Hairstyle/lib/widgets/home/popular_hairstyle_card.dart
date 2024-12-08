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
    return Stack(
      children: [
        Container(
          width: 350, // Lebar kotak biru
          height: 200, // Tinggi kotak biru
          margin: EdgeInsets.only(top: 20, left: 20), // Margin untuk kotak biru

          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Color(0xFF1B1A55),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0), // Ruang untuk gambar
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 110), // Geser seluruh teks ke kanan dan atas
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 1), // Geser teks deskripsi ke kanan
                          child: Text(
                            description,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11, // Atur ukuran font sesuai kebutuhan
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 225, bottom: 1), // Geser teks "Model Mas Amba"
                    child: Text(
                      "Model Mas Amba",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -60, // Posisi vertikal gambar relatif terhadap Card
          left: 8, // Posisi horizontal gambar relatif terhadap Card
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(12), // Membuat sudut gambar melengkung
            child: Image.asset(
              imagePath, // Jalur file gambar
              width: 180, // Lebar gambar
              height: 300, // Tinggi gambar
              fit: BoxFit.fill, // Stretch gambar agar memenuhi ruang
            ),
          ),
        ),
      ],
    );
  }
}
