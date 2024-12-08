import 'package:flutter/material.dart';
import 'otp_page.dart'; // Pastikan VerificationPage sudah diimport
import '../services/regist_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
  // _RegisterPageState createState() => _RegisterPageState();
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final OTPService _otpService = OTPService();
  String _errorMessage = '';
  // Register logic
  void _register() async {
    String username = usernameController.text;
    String email = emailController.text;

    setState(() {
      _errorMessage = '';
    });
    try {
      bool response = await _otpService.sendOtp(username, email);
      if (response) {
        // Navigate to OTP page if OTP is sent
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpPage(username: username, email: email)),
        );
      } else {
        // // Show error if OTP sending fails
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Failed to send OTP')),
        // );
        throw Exception('Kode OTP gagal terkirim');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      _showDialogPop(_errorMessage); // Tampilkan popup error - can be replaced with String or whatever
    } finally {}
  }
  void _showDialogPop(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registrasi Gagal'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text('Mengerti'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/register_background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White container for register form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B1A55),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    // Username TextField
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Email TextField
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Password TextField
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Register Button
                    ElevatedButton(
                      onPressed: 
                        _register,
                      // () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => OtpPage(),
                      //     ),
                      //   );
                      // },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1B1A55), // Button color
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text("or", style: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(height: 16),
                    // Google Sign-In Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Tambahkan aksi untuk sign in dengan Google
                      },
                      icon: Image.asset('assets/icons/google.jpeg',
                          height: 24), // Ganti dengan ikon Google
                      label: Text(
                        "Sign in with Google",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Apple Sign-In Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Tambahkan aksi untuk sign in dengan Apple
                      },
                      icon: Image.asset('assets/icons/apple.jpeg',
                          height: 24), // Ganti dengan ikon Apple
                      label: Text(
                        "Sign in with Apple",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Kembali ke halaman login
                        },
                        child: Text(
                          "Already have an account? Login",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
