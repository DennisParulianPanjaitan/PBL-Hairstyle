import 'package:flutter/material.dart';
import '../screens/camera_page.dart'; // Impor halaman kamera

class AlertScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ikon atau gambar ilustrasi wajah
            Center(
              child: Image.asset(
                'assets/icons/menscan.png', // Sesuaikan path ke gambar Anda
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 16.0),
            // Judul
            Text(
              'Alert Before Scan',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55),
              ),
            ),
            SizedBox(height: 16.0),
            // Deskripsi
            Text(
              'For more accurate analysis results, please ensure the following conditions are met before starting the scan:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 16.0),
            // Syarat dan tips
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCheckItem('Sufficient Lighting',
                    'Ensure the environment is well-lit, with no shadows obstructing the face, and that your face is clearly visible.'),
                _buildCheckItem('Clear View of Face',
                    'Avoid wearing glasses, hats, or accessories that partially cover your face. Make sure your entire face is visible on the screen.'),
                _buildCheckItem('Stable Position',
                    'Hold the device steadily, or place it on a stable surface to prevent blurry images.'),
                _buildCheckItem('Neutral Expression',
                    'Avoid smiling, frowning, or any other facial expressions to ensure accurate face detection.'),
                _buildCheckItem('Proper Distance',
                    'Ensure the device is at an appropriate distance, usually around 30-50 cm from your face.'),
              ],
            ),
            SizedBox(height: 24.0),
            // Tombol Mulai
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1B1A55), // Warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                  ),
                );
              },
              child: Text(
                'Scan',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk tiap poin tips
  Widget _buildCheckItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Color(0xFF1B1A55), size: 20.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
