import 'package:flutter/material.dart';
import 'screens/Haircut_list_screen.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      title: 'Daftar Produk',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema warna utama aplikasi
      ),
      home: HaircutListScreen(), // Memulai dari ProductListScreen
    );
  }
}
