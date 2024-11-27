import 'package:flutter/material.dart';

class FeaturesPage extends StatefulWidget {
  @override
  _FeaturesPageState createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Features'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 16.0), // Tambah jarak atas dan bawah
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, // Jarak antar item horizontal lebih lebar
                children: [
                  _buildMenuItem(
                    index: 0,
                    activeIcon: 'assets/icons/cutp.png',
                    inactiveIcon: 'assets/icons/cut3.png',
                    label: 'Hair Cut',
                  ),
                  _buildMenuItem(
                    index: 1,
                    activeIcon: 'assets/icons/foamp.png',
                    inactiveIcon: 'assets/icons/foamb.png',
                    label: 'Hair Product',
                  ),
                  _buildMenuItem(
                    index: 2,
                    activeIcon: 'assets/icons/Locationp.png',
                    inactiveIcon: 'assets/icons/Locationb.png',
                    label: 'BarberShop',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                Center(
                  child: Text('Hair Cut'),
                ),
                Center(
                  child: Text('Hair Product'),
                ),
                Center(
                  child: Text('BarberShop'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required int index,
    required String activeIcon, // Icon aktif
    required String inactiveIcon, // Icon tidak aktif
    required String label,
  }) {
    bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF1B1A55) : Colors.white,
          border: Border.all(color: Color(0xFF1B1A55)),
          borderRadius: BorderRadius.circular(16.0), // Radius lebih kecil
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 12.0, vertical: 6.0), // Kurangi padding
        child: Row(
          children: [
            Image.asset(
              isActive
                  ? activeIcon
                  : inactiveIcon, // Ganti icon berdasarkan status
              width: 20.0, // Kurangi ukuran ikon
              height: 20.0,
            ),
            SizedBox(width: 6.0), // Kurangi jarak antara ikon dan teks
            Text(
              label,
              style: TextStyle(
                fontSize: 14.0, // Kurangi ukuran font teks
                color: isActive ? Colors.white : Color(0xFF1B1A55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
