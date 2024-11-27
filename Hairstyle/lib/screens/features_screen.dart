import 'package:flutter/material.dart';
import '../widgets/menu_button.dart'; // Import MenuButton
import 'detail_haircut.dart'; // Import DetailHaircut page

class FeaturesPage extends StatefulWidget {
  @override
  _FeaturesPageState createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: 50.0), // Mengurangi jarak antara menu bar dan content
          Container(
            height: 60,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuButton(
                    activeImagePath: 'assets/icons/cutp.png',
                    inactiveImagePath: 'assets/icons/cut3.png',
                    label: 'Hair Cut',
                    isSelected: _currentIndex == 0,
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),
                  MenuButton(
                    activeImagePath: 'assets/icons/foamp.png',
                    inactiveImagePath: 'assets/icons/foamb.png',
                    label: 'Hair Product',
                    isSelected: _currentIndex == 1,
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),
                  MenuButton(
                    activeImagePath: 'assets/icons/Locationp.png',
                    inactiveImagePath: 'assets/icons/Locationb.png',
                    label: 'BarberShop',
                    isSelected: _currentIndex == 2,
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                // Hair Cut Tab
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5, // Jumlah item BarberShop
                    itemBuilder: (context, index) {
                      return _buildHairCutTab(
                        context, // Pass context here
                        'assets/images/photo.png', // Gambar
                        "Buzzcut", // Nama
                        "Buzzcut adalah gaya rambut sangat pendek yang dicukur merata diseluruh kepala", // Deskripsi
                      );
                    },
                  ),
                ),
                // Hair Product Tab
                Center(
                  child: Text(
                    'Hair Product',
                    style: TextStyle(
                      color: _currentIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
                // BarberShop Tab
                Center(
                  child: Text(
                    'BarberShop',
                    style: TextStyle(
                      color: _currentIndex == 2 ? Colors.blue : Colors.grey,
                    ),
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

Widget _buildHairCutTab(
    BuildContext context, String imagePath, String name, String desc) {
  return GestureDetector(
    onTap: () {
      // Navigate to DetailHaircut page when the item is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailHaircut(),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(
          left: 22.0, right: 22.0, top: 10.0), // Mengurangi margin atas
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255), // Warna latar belakang
        borderRadius:
            BorderRadius.circular(16), // Radius untuk sudut melengkung
        border: Border.all(
          color: Color(0xFF1B1A55), // Warna garis tepi
          width: 2, // Ketebalan garis tepi
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Row untuk menata foto dan teks
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar tetap dalam ukuran yang tetap
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePath,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Kolom untuk menata teks
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
                        const SizedBox(height: 8),
                        Text(
                          desc,
                          style: TextStyle(
                            color: Color(0xFF1B1A55),
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Memindahkan ikon lebih ke kanan dan atas
              Positioned(
                top: -15, // Mengatur posisi vertikal sedikit lebih ke atas
                right: -15, // Mengatur posisi horizontal lebih ke kanan
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border),
                  color: Color(0xFF1B1A55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Oval   |   Round   |   Square',
            style: TextStyle(
              color: Color(0xFF1B1A55),
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
