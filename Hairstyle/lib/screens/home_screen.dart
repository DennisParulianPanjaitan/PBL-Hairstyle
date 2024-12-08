import 'package:flutter/material.dart';

import '../widgets/home/popular_hairstyle_card.dart';
import '../widgets/home/barbershop_data.dart';
import '../widgets/home/barber_shop_card.dart'; // Import BarberShopCard
import '../widgets/home/hair_type_card.dart'; // Import BarberShopCard

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Bagian atas: Scrollable Content
          SingleChildScrollView(
            // Membungkus seluruh bagian atas dengan SingleChildScrollView
            child: Column(
              children: [
                // Bagian Header
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 50.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Afrizal",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Welcome to HairMate",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          'assets/images/home_profile.jpeg',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // Bagian Popular hairstyle this month
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                        child: Text(
                          "Popular hairstyle this month",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: PageView.builder(
                          itemCount: 5,
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return PopularHairstyleCard(
                              title: "Buzz Cut",
                              description:
                                  "Buzz cut adalah gaya rambut sangat pendek yang dicukur merata di seluruh kepala. Gaya ini mudah dirawat, memberikan tampilan bersih dan maskulin, serta cocok untuk berbagai bentuk wajah.",
                              imagePath: 'assets/images/masamba.jpeg',
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 30),
                          ...List.generate(
                            5,
                            (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: currentPage == index ? 30 : 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: currentPage == index
                                    ? Color(0xFF1B1A55)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Jarak dengan bagian Barbershop

                      // Bagian Barbershop
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "BarberShop",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B1A55),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Aksi ketika "See all" ditekan
                              },
                              child: Text(
                                "See all",
                                style: TextStyle(color: Color(0xFF1B1A55)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 135,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                              left: 18), // Menambahkan jarak di sisi kiri
                          itemCount: barberShops.length,
                          itemBuilder: (context, index) {
                            final barber = barberShops[index];
                            return BarberShopCard(
                              name: barber["name"],
                              price: barber["price"],
                              rating: barber["rating"],
                              imagePath: barber["imagePath"],
                            );
                          },
                        ),
                      ),

                      SizedBox(
                          height: 20), // Jarak antara Barbershop dan Hair Type

                      // Bagian Hair Type
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hair Type",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B1A55),
                              ),
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  HairTypeCard(
                                      imagePath: 'assets/images/straight.jpeg',
                                      label:
                                          'Straight' // Menentukan tinggi kotak
                                      ),
                                  SizedBox(width: 25), // Jarak antar gambar
                                  HairTypeCard(
                                      imagePath: 'assets/images/wavy.jpeg',
                                      label: 'Wave'),
                                  SizedBox(width: 25), // Jarak antar gambar
                                  HairTypeCard(
                                      imagePath: 'assets/images/curly.jpeg',
                                      label: 'Curly'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
