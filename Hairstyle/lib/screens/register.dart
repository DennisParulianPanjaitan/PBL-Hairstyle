import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

class RegisterPage extends StatelessWidget {
  // const RegisterPage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading dialog
            showDialog(
              context: context,
              builder: (_) => Center(child: CircularProgressIndicator()),
              barrierDismissible: false,
            );
          } else if (state is AuthSuccess) {
            Navigator.pop(context); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration Successful!')),
            );
          } else if (state is AuthFailure) {
            Navigator.pop(context); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message, // Tampilkan pesan error
                  maxLines: 2, // Batas jumlah baris
                  overflow: TextOverflow
                      .ellipsis, // Gunakan ellipsis jika terlalu panjang
                ),
                duration: Duration(seconds: 3), // Durasi tampil
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/register_background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey, // Warna filter
                  BlendMode.saturation, // Mode blending untuk greyscale
                ),
                child: Image.asset(
                  'assets/images/register_background.jpeg',
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
                        onPressed: () {
                          final username = usernameController.text;
                          final email = emailController.text;
                          final password = passwordController.text;
// Validasi input
                          if (username.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('All fields are required')),
                            );
                            return;
                          }

                          context.read<AuthBloc>().add(
                                RegisterEvent(
                                  username: username,
                                  email: email,
                                  password: password,
                                ),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(
                              0xFF1B1A55), // Ganti warna sesuai dengan kebutuhan Anda
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Mengurangi radius
                          ),
                        ),
                        child: Text('Register',
                            style: TextStyle(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255))),
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
      ),
    );
  }
}
