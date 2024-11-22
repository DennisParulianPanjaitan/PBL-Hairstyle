import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          children: [
            Text(
              "Hi, Afrizal",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  'assets/images/home_profile.jpeg'), // Gambar profil
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              "Welcome to HairMate",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            // Popular Hairstyle Section
            Text(
              "Popular hairstyle this month",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 180,
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                children: [
                  _buildPopularHairstyleCard(
                    "Buzz Cut",
                    "Buzz cut adalah gaya rambut sangat pendek yang dicukur merata di seluruh kepala. Gaya ini mudah dirawat, memberikan tampilan bersih dan maskulin, serta cocok untuk berbagai bentuk wajah.",
                    'assets/images/masamba.jpeg', // Ganti dengan gambar yang sesuai
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Hair Type Section
            Text(
              "Hair Type",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
            color: Color(0xFF1B1A55),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHairTypeCard(
                    "Straight Hair", "assets/images/straight.jpeg"),
                _buildHairTypeCard("Wavy Hair", "assets/images/wavy.jpeg"),
                _buildHairTypeCard("Curly Hair", "assets/images/curly.jpeg"),
              ],
            ),
            SizedBox(height: 20),
            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomButton("Hair Style"),
                _buildBottomButton("Hair Treatment"),
                _buildBottomButton("Hair Product"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularHairstyleCard(
      String title, String description, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Color(0xFF1B1A55),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 150,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    "Model Mas Amba",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
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

  Widget _buildHairTypeCard(String title, String imagePath) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black
                .withOpacity(0.5), // Latar belakang hitam transparan
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 2), // Arah bayangan
                  blurRadius: 4.0, // Membuat bayangan halus
                  color: Colors.black.withOpacity(0.8), // Warna bayangan
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF1B1A55),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
