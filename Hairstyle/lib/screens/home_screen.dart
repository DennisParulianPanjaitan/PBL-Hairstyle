import 'package:flutter/material.dart';
import '../widgets/home/popular_hairstyle_card.dart';
import '../widgets/home/hair_type_card.dart';
import '../widgets/home/barber_shop_card.dart';
import '../widgets/home/hair_product_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMenu = "Hair Style";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, Afrizal"),
        backgroundColor: Colors.white,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/home_profile.jpeg'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Popular hairstyle this month"),
            SizedBox(
              height: 180,
              child: PageView(
                children: [
                  PopularHairstyleCard(
                    title: "Buzz Cut",
                    description: "Buzz cut adalah gaya rambut...",
                    imagePath: 'assets/images/masamba.jpeg',
                  ),
                ],
              ),
            ),
            // Text("Hair Type"),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     HairTypeCard("Straight Hair", "assets/images/straight.jpeg"),
            //     HairTypeCard("Wavy Hair", "assets/images/wavy.jpeg"),
            //     HairTypeCard("Curly Hair", "assets/images/curly.jpeg"),
            //   ],
            // ),
            // Text("BarberShop"),
            // SizedBox(
            //   height: 180,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 5,
            //     itemBuilder: (context, index) {
            //       return BarberShopCard(
            //         name: "GoodFellas",
            //         price: "Rp 20.000 - 500.000",
            //         rating: 4.5,
            //         imagePath: 'assets/images/barbershop_example.jpeg',
            //       );
            //     },
            //   ),
            // ),
            // Text("Hair Product"),
            // SizedBox(
            //   height: 180,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 3,
            //     itemBuilder: (context, index) {
            //       List<Map<String, dynamic>> products = [
            //         {"name": "Pomade", "description": "Shine • Hold • Texture", "image": "assets/images/hair_pomade.png"},
            //         {"name": "Hair Clay", "description": "Nourishes and styles", "image": "assets/images/hair_clay.png"},
            //         {"name": "Hair Powder", "description": "Volume • Matte finish", "image": "assets/images/hair_powder.png"},
            //       ];
            //       var product = products[index];
            //       return HairProductCard(
            //         name: product['name'],
            //         description: product['description'],
            //         imagePath: product['image'],
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
