import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/splash_screen.dart'; // Import SplashScreen dari folder screens
import 'bloc/login/login_bloc.dart'; // Import LoginBloc
import 'services/auth_service.dart'; // Import AuthService

void main() {
  runApp(HairMateApp());
}

class HairMateApp extends StatelessWidget {
  const HairMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authService: AuthService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // Set SplashScreen sebagai layar utama
      ),
    );
  }
}
