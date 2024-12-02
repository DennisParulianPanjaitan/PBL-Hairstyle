import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_page.dart'; // Import halaman tujuan
import 'forgot_password.dart';
import 'register.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isPasswordVisible = false;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );
      // Handle success
      print('Login successful: $response');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', response['token']);

      // Navigate to HomePage
      if (mounted) { // Periksa apakah widget masih aktif
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage()
        ),
      );
    }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      _showErrorDialog(
          _errorMessage); // Tampilkan popup error - can be replaced with String or whatever
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text('OK'),
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
                image: AssetImage('assets/images/login.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White container for login form
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
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B1A55),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    // Username / Email TextField
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Username / Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Password TextField
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password? click here",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Login Button
                    ElevatedButton(
                      onPressed: // _isLoading ? null : _login,
                          () {
                        // Navigasi ke halaman home_page.dart
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1B1A55), // Button color
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "Login",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Don't have an account? Register",
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
