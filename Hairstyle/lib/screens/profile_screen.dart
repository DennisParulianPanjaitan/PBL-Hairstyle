import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uts_linkaja/screens/contact_us.dart';
import 'package:uts_linkaja/screens/help_support_screen.dart';
import 'package:uts_linkaja/screens/history.dart';
import 'package:uts_linkaja/screens/privacy_policy_screen.dart';
import 'package:uts_linkaja/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  String profilePictureUrl = "";
  int userId = -1;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _loadProfileData();
    // _loadProfileImage();
    _loadProfilePictureUrl();
  }

  void _loadProfilePictureUrl() async {
    String url = await getProfilePictureUrl();
    setState(() {
      profilePictureUrl = url;
    });
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('id') ?? 0;
    setState(() {
      emailController.text = prefs.getString('email') ?? '';
      usernameController.text = prefs.getString('username') ?? 'Bro';
      passwordController.text = prefs.getString('password') ?? '';
    });
  }

  Future<void> _updateProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      emailController.text = prefs.getString('email') ?? '';
      usernameController.text = prefs.getString('username') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    if (emailController.text.isEmpty &&
        usernameController.text.isEmpty &&
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are still empty')),
      );
      return;
    }
    String email = emailController.text.isNotEmpty
        ? emailController.text
        : prefs.getString('email') ?? '';
    String username = usernameController.text.isNotEmpty
        ? usernameController.text
        : prefs.getString('username') ?? '';

    final url = Uri.parse(
        'https://hairmate.smartrw.my.id/api/updateuser'); // Replace with your API endpoint

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Use JSON format
        },
        body: jsonEncode({
          'id': userId,
          'email': email,
          'username': username,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await prefs.setString('email', email);
        await prefs.setString('username', username);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );

        // Return to the previous screen with success signal
        // Navigator.pop(context, true);
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No new data updated')),
        );
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: ${response.body}')),
        );
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('username', username);
    // await prefs.setString('email', email);
    setState(() {
      emailController.text = prefs.getString('email') ?? '';
      usernameController.text = prefs.getString('username') ?? '';
    });
  }

  String profileImagePath = '';

  Future<File?> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profilePictureUrl = pickedFile.path;
      });

      // Simpan path gambar ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profilePictureUrl', profilePictureUrl);

      // Mengembalikan File yang sesuai
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String> uploadProfileImage(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final url = Uri.parse("https://hairmate.smartrw.my.id/api/simpan-pp");
    String localUrl = imageFile.path;
    final request = http.MultipartRequest("POST", url)
      ..fields['user_id'] = userId.toString()
      ..files.add(await http.MultipartFile.fromPath('image', localUrl));
    ;
    // request.files.add(await http.MultipartFile.fromPath('image', localUrl));
    final response = await request.send();

    if (response.statusCode == 200) {
      // Berhasil, ambil URL yang dikembalikan server
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);
      if (decodedResponse['success']) {
        print('Scan history saved successfully!');
      } else {
        print('Failed to save scan history: ${decodedResponse['message']}');
      }

      return decodedResponse['image_url']; // URL dikembalikan sebagai teks
    } else {
      // Gagal
      print("Failed to upload image: ${response.statusCode}");
      return 'Gagal';
    }
  }

  Future<bool> saveProfileImageUrl(int? userId, String imageUrl) async {
    final url =
        Uri.parse("https://hairmate.smartrw.my.id/api/user/unggahppurl");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userId": userId,
        "profileImageUrl": imageUrl,
      }),
    );

    return response.statusCode == 200;
  }

  Future<void> updateProfileImage() async {
    // 1. Pilih gambar
    final imageFile = await _pickProfileImage();
    if (imageFile == null) {
      // print("No image selected");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
      return;
    }
    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    // 2. Unggah gambar ke server
    final imageUrl = await uploadProfileImage(imageFile);
    // print(imageUrl);
    if (imageUrl == "Gagal") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_picture_url', imageUrl);
    Navigator.pop(context); // Close the loading indicator

    setState(() {
      profilePictureUrl = imageUrl;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile image updated successfully!')),
    );
  }

  Future<String> getProfilePictureUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_picture_url') ?? '';
  }

  // Future<void> _loadProfileImage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     profilePictureUrl = prefs.getString('profilePictureUrl');
  //   });
  // }
  bool _isPasswordVisible = false;
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
                      // ignore: unnecessary_null_comparison
                      backgroundImage: profilePictureUrl.isNotEmpty
                          ? (profilePictureUrl
                                  .startsWith('http') // Cek apakah ini URL
                              ? NetworkImage(profilePictureUrl) as ImageProvider
                              : FileImage(File(profilePictureUrl)))
                          : null,
                      child:
                          profilePictureUrl == "" || profilePictureUrl.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                )
                              : null,
                      // child: const Icon(
                      //   Icons.person,
                      //   size: 50,
                      //   color: Colors.grey,
                      // ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          await updateProfileImage();
                        },
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Name
              Text(
                usernameController.text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              // Email
              Text(
                // 'amber@gmail.com',
                emailController.text,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              // Form Fields
              _buildTextField(
                label: 'Email',
                controller: emailController,
                hint: 'xxx@example.com',
                icon: Image.asset(
                  'assets/icons/Message.png', // Gambar email
                  width: 24,
                  height: 24,
                ),
              ),

              const SizedBox(height: 16),
              _buildTextField(
                label: 'Username',
                controller: usernameController,
                hint: 'Email Anda',
                icon: Image.asset(
                  'assets/icons/Profile.png', // Gambar email
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(height: 16),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(
                  "Password",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: !_isPasswordVisible, // Atur visibilitas password
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(171, 171, 171, 100),
                      fontSize: 16,
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
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
              ]),
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
                        'Batal',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Jarak antar tombol
                  SizedBox(
                    width: 120, // Atur lebar tombol Save
                    child: ElevatedButton(
                      onPressed: _saveProfileData,
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
              onPressed: () async {
                // Implement your logout logic here
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Hapus semua data

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
    required TextEditingController controller,
    bool obscureText =
        false, // Tambahkan parameter untuk mendukung toggle password visibility
    void Function()? toggleVisibility, // Callback untuk toggle visibility
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
          controller: controller,
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
            // Tambahkan suffixIcon hanya untuk password
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: toggleVisibility, // Panggil toggleVisibility
                  )
                : null,
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