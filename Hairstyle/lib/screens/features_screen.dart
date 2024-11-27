import 'package:flutter/material.dart';

import '../widgets/menu_button.dart'; // Import MenuButton

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
          SizedBox(height: 50.0), // Jarak dari atas layar ke menu
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Ganti _buildMenuItem dengan MenuButton
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
              children: const [
                Center(child: Text('Hair Cut')),
                Center(child: Text('Hair Product')),
                Center(child: Text('BarberShop')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
