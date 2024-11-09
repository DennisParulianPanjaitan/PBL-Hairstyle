import 'package:flutter/material.dart';
import 'camera_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Tab $_selectedIndex selected'),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 21.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view, size: 21.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 21.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 21.0),
                label: '',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 48.0,
        width: 48.0,
        child: FloatingActionButton(
          onPressed: () {
            // Navigasi ke CameraPage tanpa passing controller
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraPage(),
              ),
            );
          },
          child: Icon(Icons.camera_alt, size: 24.0),
          backgroundColor: Color(0xFF1B1A55),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
