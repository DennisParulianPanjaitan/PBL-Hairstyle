import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import SplashScreen dari folder screens

void main() {
  runApp(HairMateApp());
}

class HairMateApp extends StatelessWidget {
  const HairMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set SplashScreen sebagai layar utama
    );
  }
}
