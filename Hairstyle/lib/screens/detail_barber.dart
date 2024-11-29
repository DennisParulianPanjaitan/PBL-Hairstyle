import 'package:flutter/material.dart';

class DetailBarber extends StatelessWidget {
  const DetailBarber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama memenuhi layar
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/images/barbershop.jpeg', // Ganti dengan path gambar Anda
                width: double.infinity,
                height: 300, // Tinggi gambar lebih besar
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Informasi Barbershop
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "GoodFellas",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF1B1A55), // Warna biru
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "4.5",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B1A55), // Warna biru
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Color(0xFF1B1A55)), // Warna biru
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Jl. Ratuw No.4, Oro-oro Dowo, Klojen, Malang, 65115",
                          style: TextStyle(
                            color: Color(0xFF1B1A55), // Warna biru
                            fontWeight: FontWeight.bold, // Teks tebal
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Color(0xFF1B1A55)), // Warna biru
                      const SizedBox(width: 8),
                      Text(
                        "9am - 10pm, Mon-Sun",
                        style: TextStyle(
                          color: Color(0xFF1B1A55), // Warna biru
                          fontWeight: FontWeight.bold, // Teks tebal
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Deskripsi
                  Text(
                    "GoodFellas offers a complete range of services for men, including haircuts, shaving, coloring, and various treatments such as massages, grooming, and the latest facial trends. Enjoy our clean shaving area for optimal hygiene, ensuring you always look fresh and confident!",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),

                  // Kontak
                  Text(
                    "Contact",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1A55), // Warna biru
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.language, color: Color(0xFF1B1A55)), // Warna biru
                      const SizedBox(width: 8),
                      Text(
                        "instagram.com",
                        style: TextStyle(
                          color: Color(0xFF1B1A55), // Warna biru
                          fontWeight: FontWeight.bold, // Teks tebal
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Color(0xFF1B1A55)), // Warna biru
                      const SizedBox(width: 8),
                      Text(
                        "082123456789",
                        style: TextStyle(
                          color: Color(0xFF1B1A55), // Warna biru
                          fontWeight: FontWeight.bold, // Teks tebal
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Layanan
                  Text(
                    "Services",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1A55), // Warna biru
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildServiceIcon(Icons.content_cut, "Hair Cut"),
                      _buildServiceIcon(Icons.brush, "Coloring"),
                      _buildServiceIcon(Icons.face, "Shaving"),
                      _buildServiceIcon(Icons.spa, "Treatment"),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Galeri
                  Text(
                    "Galeri",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1A55), // Warna biru
                    ),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/barbergallery_$index.jpeg', // Ganti dengan gambar galeri Anda
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
    );
  }

  Widget _buildServiceIcon(IconData iconData, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Color(0xFF1B1A55),
          child: Icon(iconData, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF1B1A55),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
