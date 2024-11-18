import 'package:flutter/material.dart';
import '../screens/camera_page.dart'; 



class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

 BottomNavBar({
    required this.selectedIndex,  
    required this.onItemTapped,   
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.transparent,
        elevation: 30.0,
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0.0,
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  onItemTapped(0);
                },
                icon: selectedIndex == 0
                    ? Image.asset('assets/icons/HomeBold.png', width: 24.0, height: 24.0)
                    : Image.asset('assets/icons/HomeOut.png', width: 24.0, height: 24.0),
              ),
              IconButton(
                onPressed: () {
                  onItemTapped(1);
                },
                icon: selectedIndex == 1
                    ? Image.asset('assets/icons/CategoryBold.png', width: 24.0, height: 24.0)
                    : Image.asset('assets/icons/CategoryOut.png', width: 24.0, height: 24.0),
              ),
              SizedBox(width: 56.0),
              IconButton(
                onPressed: () {
                  onItemTapped(2);
                },
                icon: selectedIndex == 2
                    ? Image.asset('assets/icons/HeartBold.png', width: 24.0, height: 24.0)
                    : Image.asset('assets/icons/HeartOut.png', width: 24.0, height: 24.0),
              ),
              IconButton(
                onPressed: () {
                  onItemTapped(3);
                },
                icon: selectedIndex == 3
                    ? Image.asset('assets/icons/ProfileBold.png', width: 24.0, height: 24.0)
                    : Image.asset('assets/icons/ProfileOut.png', width: 24.0, height: 24.0),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 80.0,
        width: 80.0,
        child: FloatingActionButton(
          onPressed: () {
            // Navigasi ke CameraPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraPage(),
              ),
            );
          },
          backgroundColor: Color(0xFF1B1A55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Image.asset('assets/icons/camera.png', width: 30.0, height: 30.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
