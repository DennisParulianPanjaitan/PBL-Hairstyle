import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Color(0xFF1B1A55),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildContactOption(
              icon: Icons.headset_mic,
              title: 'Email',
              content: 'Email: support@HairMate.com\nPhone: +1 800 123',
            ),
            _buildContactOption(
              icon: Icons.headset_mic,
              title: 'WhatsApp',
              content: '+62 12345678',
            ),
            _buildContactOption(
              icon: Icons.language,
              title: 'Website',
              content: 'www.HairMate.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(
      {required IconData icon,
      required String title,
      required String content}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Maintain rounded corners
      ),
      elevation: 4, // Optional: adds shadow
      child: ExpansionTile(
        leading: Icon(icon, color: Color(0xFF1B1A55)),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B1A55)),
        ),
        collapsedBackgroundColor:
            Colors.white, // Background color when collapsed
        backgroundColor: Color(0xFFE9F0FF), // Background color when expanded
        tilePadding: EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}





  // Widget _buildContactForm() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Name',
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 8),
  //       TextField(
  //         decoration: InputDecoration(
  //           hintText: 'Enter your name',
  //           border: OutlineInputBorder(),
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       const Text(
  //         'Email',
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 8),
  //       TextField(
  //         decoration: InputDecoration(
  //           hintText: 'Enter your email',
  //           border: OutlineInputBorder(),
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       const Text(
  //         'Message',
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 8),
  //       TextField(
  //         maxLines: 5,
  //         decoration: InputDecoration(
  //           hintText: 'Enter your message',
  //           border: OutlineInputBorder(),
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //     ],
  //   );
  // }
