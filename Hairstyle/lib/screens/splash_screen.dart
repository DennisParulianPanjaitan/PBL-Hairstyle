import 'package:flutter/material.dart';
import 'login.dart'; // Import LoginPage

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 3), () async {
    //   // Cek apakah sudah login dengan token di SharedPreferences
    //   final prefs = await SharedPreferences.getInstance();
    //   final token = prefs.getString('jwt_token');
    //   if (token != null) {
    //     Navigator.pushReplacementNamed(
    //         context, '/home'); // Jika sudah login, langsung ke Home
    //   } else {
    //     Navigator.pushReplacementNamed(
    //         context, '/login'); // Jika belum login, ke halaman login
    //   }
    // });
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation, // Efek grayscale
            ),
            child: Image.asset(
              'assets/images/hairstyle.jpeg',
              fit: BoxFit.cover, // Gambar mengisi seluruh area
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment(0.0, -1.0), // Geser gambar lebih ke atas
            ),
          ),
          Container(
            decoration: BoxDecoration(
                // Tambahkan elemen lain ke dekorasi jika diperlukan
                ),
          ),
          // Teks di bagian atas
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 60.0), // Jarak dari atas layar
              child: Text(
                "Discover the hairstyle\nthat matches your face",
                textAlign: TextAlign.center, // Align text to center
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900, // Ketebalan maksimal
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // White container with cut-out corner on top right
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper:
                  TopRightCornerClipper(), // Custom clipper for top right corner
              child: Container(
                height: MediaQuery.of(context).size.height *
                    0.35, // Covers 35% of screen
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0), // Adjust padding to fit lower area
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HairMate",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Scan, Style, and Shine with HairMate! Effortlessly discover the perfect hairstyle tailored just for you and elevate your look with confidence every day.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double
                            .infinity, // Lebar penuh sesuai dengan parent container
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigasi ke halaman login
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1B1A55), // Warna tombol
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CustomClipper for creating a curve on the top right corner
class TopRightCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0); // Start at top left
    path.lineTo(size.width * 0.8, 0); // Move to 80% across top
    path.quadraticBezierTo(size.width, 0, size.width,
        size.height * 0.2); // Curve at top right corner
    path.lineTo(size.width, size.height); // Move straight down the right side
    path.lineTo(0, size.height); // Move back to the bottom left
    path.close(); // Complete the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
