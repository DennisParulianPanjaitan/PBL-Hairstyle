import 'package:flutter/material.dart';
import 'package:uts_linkaja/screens/features_screen.dart';
import 'camera_page.dart'; // Pastikan ini sudah diimpor
import 'home_screen.dart';
import 'category_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import '../widgets/bottom_navbar.dart'; // Pastikan ini sudah diimpor
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _token;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('jwt_token'); // Ambil token dari SharedPreferences
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    FeaturesPage(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai index
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
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
          child:
              Image.asset('assets/icons/camera.png', width: 30.0, height: 30.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
