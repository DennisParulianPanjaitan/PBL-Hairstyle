import 'package:flutter/material.dart';

class CreateNewPasswordPage extends StatefulWidget {
  @override
  _CreateNewPasswordPageState createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  void validatePassword(String password) {
    setState(() {
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasLowerCase = password.contains(RegExp(r'[a-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasMinLength = password.length >= 8;
    });
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
                image: AssetImage('assets/images/createnew.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White container for form
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create New Password",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1A55),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "This password should be different from the previous password.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  // New Password Field
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    onChanged: validatePassword,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Confirm Password Field
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Password validation
                  Row(
                    children: [
                      Icon(
                        hasMinLength ? Icons.check_circle : Icons.cancel,
                        color: hasMinLength ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text("At least 8 characters"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        hasNumber ? Icons.check_circle : Icons.cancel,
                        color: hasNumber ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text("At least 1 number"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        (hasUpperCase && hasLowerCase)
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: (hasUpperCase && hasLowerCase)
                            ? Colors.green
                            : Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text("Both upper and lower case letters"),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Reset Password Button
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan aksi setelah reset password
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1B1A55),
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
