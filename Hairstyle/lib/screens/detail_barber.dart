import 'package:flutter/material.dart';

class DetailBarber extends StatelessWidget {
  const DetailBarber({super.key});

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
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
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
                        fontSize: 30,
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
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/icons/loc.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 8), // Memberi jarak horizontal
                        Expanded(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              "Jl. Ratuw No.4, Oro-oro Dowo, Klojen, Malang, 65115",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1B1A55),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/icons/label.png',
                            fit: BoxFit.contain,
                          ),
                        ), // Warna biru
                        const SizedBox(width: 8),
                        Text(
                          "Rp 20.000 - 500.000",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1B1A55), // Warna biru
                            fontWeight: FontWeight.bold, // Teks tebal
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/icons/jam.png',
                            fit: BoxFit.contain,
                          ),
                        ), // Warna biru
                        const SizedBox(width: 8),
                        Text(
                          "9am - 10pm, Mon-Sun",
                          style: TextStyle(
                            fontSize: 16,
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B1A55), // Warna biru
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/icons/instagram.png',
                            fit: BoxFit.contain,
                          ),
                        ), // Warna biru
                        const SizedBox(width: 8),
                        Text(
                          "instagram.com",
                          style: TextStyle(
                            color: Color(0xFF1B1A55),
                            fontSize: 16,
                            fontWeight: FontWeight.bold, // Teks tebal
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/icons/telpon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "082123456789",
                          style: TextStyle(
                            fontSize: 16,
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B1A55), // Warna biru
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildServiceIcon(
                          Image.asset(
                            'assets/icons/haircut.png',
                            width:
                                40, // Ukuran gambar yang sesuai dengan CircleAvatar
                            height: 40,
                          ),
                          "Hair Cut",
                        ),
                        _buildServiceIcon(
                          Image.asset(
                            'assets/icons/coloring.png',
                            width:
                                40, // Ukuran gambar yang sesuai dengan CircleAvatar
                            height: 40,
                          ),
                          "Coloring",
                        ),
                        _buildServiceIcon(
                          Image.asset(
                            'assets/icons/shaving.png',
                            width:
                                40, // Ukuran gambar yang sesuai dengan CircleAvatar
                            height: 40,
                          ),
                          "Shaving",
                        ),
                        _buildServiceIcon(
                          Image.asset(
                            'assets/icons/treatment.png',
                            width:
                                40, // Ukuran gambar yang sesuai dengan CircleAvatar
                            height: 40,
                          ),
                          "Treatment",
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Galeri
                    Text(
                      "Galeri",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B1A55), // Warna biru
                      ),
                    ),
                    const SizedBox(height: 5),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
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
      ),
    );
  }

  Widget _buildServiceIcon(Widget icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFF1B1A55),
          child: SizedBox(
            width: 40,
            height: 40,
            child: icon, // Menampilkan ikon sebagai gambar atau widget lainnya
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF1B1A55),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
