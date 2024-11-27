import 'package:flutter/material.dart';

import '../widgets/menu_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Menyimpan menu aktif
  String selectedMenu = "Hair Style";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
              radius: 24,
              backgroundImage: AssetImage(
                  'assets/images/home_profile.jpeg'), // Gambar profil
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Popular hairstyle this month",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 180,
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                children: [
                  _buildPopularHairstyleCard(
                    "Buzz Cut",
                    "Buzz cut adalah gaya rambut sangat pendek yang dicukur merata di seluruh kepala. Gaya ini mudah dirawat, memberikan tampilan bersih dan maskulin, serta cocok untuk berbagai bentuk wajah.",
                    'assets/images/masamba.jpeg',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MenuButton(
                  activeImagePath:
                      "assets/icons/cutp.png", // Ganti dengan path gambar aktif
                  inactiveImagePath:
                      "assets/icons/cutb.png", // Ganti dengan path gambar tidak aktif
                  label: "Hair Cut",
                  isSelected: selectedMenu == "Hair Cut",
                  onTap: () {
                    setState(() {
                      selectedMenu = "Hair Cut";
                    });
                  },
                ),
                MenuButton(
                  activeImagePath:
                      "assets/icons/foamp.png", // Ganti dengan path gambar aktif
                  inactiveImagePath:
                      "assets/icons/foamb.png", // Ganti dengan path gambar tidak aktif
                  label: "Hair Product",
                  isSelected: selectedMenu == "Hair Product",
                  onTap: () {
                    setState(() {
                      selectedMenu = "Hair Product";
                    });
                  },
                ),
                MenuButton(
                  activeImagePath:
                      "assets/icons/Locationp.png", // Ganti dengan path gambar aktif
                  inactiveImagePath:
                      "assets/icons/Locationb.png", // Ganti dengan path gambar tidak aktif
                  label: "Barbershop",
                  isSelected: selectedMenu == "Barbershop",
                  onTap: () {
                    setState(() {
                      selectedMenu = "Barbershop";
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "BarberShop",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B1A55),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Aksi saat "See all" ditekan
                    print("See all BarberShop tapped");
                  },
                  child: Row(
                    children: [
                      Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1B1A55),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Color(0xFF1B1A55),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 180, // Atur tinggi sesuai kebutuhan
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Jumlah item BarberShop
                itemBuilder: (context, index) {
                  return _buildBarberShopCard(
                    "GoodFellas",
                    "Rp 20.000 - 500.000",
                    4.5,
                    'assets/images/barbershop_example.jpeg',
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hair Product",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B1A55),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Aksi saat "See all" ditekan
                    print("See all Hair Product tapped");
                  },
                  child: Row(
                    children: [
                      Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1B1A55),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Color(0xFF1B1A55),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 180, // Atur tinggi sesuai kebutuhan
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Jumlah produk Hair Product
                itemBuilder: (context, index) {
                  // Data produk contoh
                  List<Map<String, dynamic>> products = [
                    {
                      "name": "Pomade",
                      "description": "Shine • Hold • Texture",
                      "image": "assets/images/pomade.jpeg",
                    },
                    {
                      "name": "Hair Clay",
                      "description": "Nourishes and styles the beard",
                      "image": "assets/images/hair_wax.jpeg",
                    },
                    {
                      "name": "Hair Powder",
                      "description": "Volume • Matte finish",
                      "image": "assets/images/hair_powder.jpeg",
                    },
                  ];

                  var product = products[index];
                  return _buildHairProductCard(
                    product['name'],
                    product['description'],
                    product['image'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularHairstyleCard(
      String title, String description, String imagePath) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 320,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Color(0xFF1B1A55),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(width: 140),
                  Expanded(
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
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -72,
          left: 4,
          child: Container(
            width: 120,
            height: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
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
            color: Colors.black.withOpacity(0.5),
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarberShopCard(
      String name, String price, double rating, String imagePath) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHairProductCard(
      String name, String description, String imagePath) {
    return Container(
      width: 140, // Atur lebar kartu
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
