import 'package:flutter/material.dart';
import 'detail_haircut.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar data haircut
    final haircuts = [
      {
        'image': 'assets/images/photo.png',
        'title': 'Square',
        'description':
            'Gunakan pomade atau clay daya tahan tinggi untuk Buzz Cut dan Mullet yang rapi, serta dry shampoo dan serum untuk menjaga kesegaran dan kesehatan rambut pada gaya Man Bun.',
        'date': '2024-12-02',
      },
      {
        'image': 'assets/images/photo.png',
        'title': 'Rectangular',
        'description':
            'Gunakan pomade atau clay daya tahan tinggi untuk Buzz Cut dan Mullet yang rapi, serta dry shampoo dan serum untuk menjaga kesegaran dan kesehatan rambut pada gaya Man Bun.',
        'date': '2024-11-25',
      },
      {
        'image': 'assets/images/photo.png',
        'title': 'Heart',
        'description':
            'Gunakan pomade atau clay daya tahan tinggi untuk Buzz Cut dan Mullet yang rapi, serta dry shampoo dan serum untuk menjaga kesegaran dan kesehatan rambut pada gaya Man Bun.',
        'date': '2024-11-18',
      },
      {
        'image': 'assets/images/photo.png',
        'title': 'Square',
        'description':
            'Gunakan pomade atau clay daya tahan tinggi untuk Buzz Cut dan Mullet yang rapi, serta dry shampoo dan serum untuk menjaga kesegaran dan kesehatan rambut pada gaya Man Bun.',
        'date': '2024-11-10',
      },
      {
        'image': 'assets/images/photo.png',
        'title': 'Oval',
        'description':
            'Gunakan pomade atau clay daya tahan tinggi untuk Buzz Cut dan Mullet yang rapi, serta dry shampoo dan serum untuk menjaga kesegaran dan kesehatan rambut pada gaya Man Bun.',
        'date': '2024-11-10',
      },
      {
        'image': 'assets/images/photo.png',
        'title': 'Rectangular',
        'description':
            'Gunakan pomade atau clay daya tahan tinggi untuk Buzz Cut dan Mullet yang rapi, serta dry shampoo dan serum untuk menjaga kesegaran dan kesehatan rambut pada gaya Man Bun.',
        'date': '2024-11-10',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow.png',
            width: 40,
            height: 40,
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF1B1A55),
        ),
        title: const Text(
          'History',
          style: TextStyle(
            color: Color(0xFF1B1A55),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(haircuts.length, (index) {
            final haircut = haircuts[index];
            return _buildHairCutItem(
              context,
              haircut['image']!,
              haircut['title']!,
              haircut['description']!,
              haircut['date']!,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHairCutItem(
    BuildContext context,
    String imagePath,
    String name,
    String desc,
    String date,
  ) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DetailHaircut(),
      //     ),
      //   );
      // },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFF1B1A55),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // Row untuk gambar dan teks, pastikan semua sejajar atas
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Pastikan sejajar atas
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    width: 130, // Memperbesar gambar
                    height: 130, // Memperbesar gambar
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Color(0xFF1B1A55),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10), // Spasi sebelum tombol
                      // Row untuk tiga tombol berbentuk kotak
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildShapeButton('Buzz cut'),
                          const SizedBox(width: 10),
                          _buildShapeButton('Man Bun'),
                          const SizedBox(width: 10),
                          _buildShapeButton('Mullet'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        desc,
                        style: TextStyle(
                          color: Color(0xFF1B1A55),
                          fontSize: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Tanggal di pojok kanan atas
            Positioned(
              right: 5,
              top: -3,
              child: Text(
                date,
                style: TextStyle(
                  color: const Color.fromARGB(255, 149, 148, 148),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShapeButton(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Radius sejajar 3
        border: Border.all(color: Color(0xFF1B1A55), width: 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xFF1B1A55),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
