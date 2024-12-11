import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home_screen.dart'; // Import SplashScreen dari folder screens
import 'screens/splash_screen.dart'; // Import SplashScreen dari folder screens
import 'screens/profile_screen.dart'; // Import SplashScreen dari folder screens
import 'screens/features_screen.dart'; // Import SplashScreen dari folder screens
import 'blocs/login/login_bloc.dart'; // Import LoginBloc
import 'blocs/auth/auth_bloc.dart'; // Import LoginBloc
import 'services/auth_service.dart'; // Import AuthService

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: const HairMateApp(),
    ),
  );
}

class HairMateApp extends StatelessWidget {
  const HairMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FeaturesPage(), // Set SplashScreen sebagai layar utama
    );
  }
}
