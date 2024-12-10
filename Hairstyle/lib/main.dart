import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uts_linkaja/screens/favorite_screen.dart';
import 'package:uts_linkaja/screens/home_screen.dart';
import 'package:uts_linkaja/screens/login.dart';
import 'blocs/auth/auth_bloc.dart';
import 'services/auth_service.dart';
import 'screens/splash_screen.dart';
import 'screens/home_page.dart';
import 'screens/features_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(HairMateApp());
}

class HairMateApp extends StatelessWidget {
  const HairMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomeScreen(),
          '/features': (context) => FeaturesPage(),
          '/bookmarked': (context) => FavoritesScreen(),
          '/profile': (context) => ProfileScreen(),
        },
      ),
    );
  }
}
