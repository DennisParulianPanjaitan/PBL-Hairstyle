import 'package:flutter/material.dart';
import 'package:uts_linkaja/screens/contact_us.dart';
import 'package:uts_linkaja/screens/help_support_screen.dart';
import 'package:uts_linkaja/screens/history.dart';
import 'package:uts_linkaja/screens/privacy_policy_screen.dart';
import 'package:uts_linkaja/screens/splash_screen.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

email() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: 'email') ?? 'default_value';
  return value;
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const floatingButtonHeight = kFloatingActionButtonMargin + 55.0;

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   // leading: IconButton(
      //   //   icon: Image.asset(
      //   //     'assets/icons/arrow.png',
      //   //     width: 40,
      //   //     height: 40,
      //   //   ),
      //   //   onPressed: () => Navigator.pop(context),
      //   // ),
      //   title: const Text(
      //     'Profile',
      //     style: TextStyle(
      //       color: Color(0xFF1B1A55),
      //       fontSize: 20,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Add padding at the bottom to prevent content from being hidden
          padding: EdgeInsets.only(
            bottom: bottomPadding + floatingButtonHeight,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Profile Image
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(),
                        child: Image.asset(
                          'assets/icons/changeprofile.png', // Ganti dengan path aset Anda
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Name
              const Text(
                'Mas Amba',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              // Email
              const Text(
                'amber@gmail.com',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              // Form Fields
              _buildTextField(
                label: 'Email',
                hint: 'xxx@gmail.com',
                icon: Image.asset(
                  'assets/icons/Message.png', // Gambar email
                  width: 24,
                  height: 24,
                ),
              ),

              const SizedBox(height: 16),
              _buildTextField(
                label: email(),
                hint: 'xxx@gmail.com',
                icon: Image.asset(
                  'assets/icons/Profile.png', // Gambar email
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Password',
                hint: '••••••••',
                icon: Image.asset(
                  'assets/icons/password.png', // Gambar email
                  width: 24,
                  height: 24,
                ),
                isPassword: true,
              ),
              const SizedBox(height: 20),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Pusatkan tombol
                children: [
                  SizedBox(
                    width: 120, // Atur lebar tombol Cancel
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Jarak antar tombol
                  SizedBox(
                    width: 120, // Atur lebar tombol Save
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              // Menu Items
              _buildMenuItem('History Scan', Icons.history, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              }),
              _buildMenuItem('Privacy and Policy', Icons.privacy_tip_outlined,
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              }),
              // _buildMenuItem('Help and Contact', Icons.help_outline, onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const HelpAndSupportScreen(),
              //     ),
              //   );
              // }),
              _buildMenuItem('Help and Contact', Icons.support_agent_outlined,
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsScreen(),
                  ),
                );
              }),
              const SizedBox(height: 16),
              // Logout Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _showLogoutDialog(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog (Cancel)
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement your logout logic here
                Navigator.of(context).pop(); // Close the dialog (Logout)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                iconColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Yes, Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required Widget icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color.fromRGBO(171, 171, 171, 100),
              fontSize: 16,
            ),
            prefixIcon: icon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF1B1A55)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF1B1A55)),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1B1A55)),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
