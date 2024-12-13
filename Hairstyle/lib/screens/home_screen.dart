import 'dart:async';
import 'package:flutter/material.dart';

import '../widgets/home/popular_hairstyle_card.dart';
import '../widgets/home/barbershop_data.dart';
import '../widgets/home/barber_shop_card.dart'; // Import BarberShopCard
import '../widgets/home/hair_type_card.dart'; // Import HairTypeCard
import '../widgets/home/hair_product_card.dart'; // Import HairTypeCar
import '../widgets/home/hair_style_card.dart'; // Import HairTypeCard
import 'detail_haircut.dart';

import 'package:uts_linkaja/services/product_service.dart';
import 'package:uts_linkaja/models/product.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> products;

  int currentPage = 0;
  ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController(initialPage: 1000);
  int _itemsPerLoad = 3; // Menampilkan 3 produk per load
  int _currentIndex = 0;
  double _headerOpacity = 1.0; // Opacity initial header
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    products = ProductService().fetchProducts(); // Simpan Future di variabel

    // Add listener to scrollController
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      setState(() {
        _headerOpacity = (1 - (offset / 100)).clamp(0, 1);
      });
    });

    // Start the auto-scroll timer
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Bagian atas: Scrollable Content
          SingleChildScrollView(
            controller: _scrollController, // Attach scroll controller
            child: Column(
              children: [
                // Bagian Header dengan animasi opacity
                Opacity(
                  opacity: _headerOpacity,
                  child: Padding(
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
                ),
                SizedBox(height: 40),

                // Kotak scrollable untuk 3 menu
                SizedBox(
                  height: 1500, // Atur tinggi tetap untuk kotak ini
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Background warna putih untuk kotak
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), // Warna bayangan
                            spreadRadius: 5, // Penyebaran bayangan
                            blurRadius: 7, // Blur radius untuk bayangan
                            offset:
                                Offset(0, 3), // Mengatur offset bayangan (x, y)
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                            12), // Opsional, untuk rounded corners
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Popular hairstyle this month
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, top: 20.0),
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
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  currentPage = index % 5;
                                });
                              },
                              itemCount: 5 *
                                  1000, // Large number to simulate infinite loop
                              itemBuilder: (context, index) {
                                final itemIndex = index % 5;
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
                          SizedBox(
                              height: 20), // Jarak dengan bagian Barbershop
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
                                  child: Row(
                                    children: [
                                      Text(
                                        "See all",
                                        style:
                                            TextStyle(color: Color(0xFF1B1A55)),
                                      ),
                                      SizedBox(
                                          width:
                                              4), // Memberikan jarak antara "See all" dan simbol
                                      Icon(
                                        Icons
                                            .arrow_forward, // Menambahkan simbol panah
                                        color: Color(0xFF1B1A55),
                                        size: 20,
                                      ),
                                    ],
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
                              height:
                                  20), // Jarak antara Barbershop dan Hair Type

                          // Bagian HAIR TYPE
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
                                          imagePath:
                                              'assets/images/straight.jpeg',
                                          label: 'Straight'),
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
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Menggabungkan "Hair Product" dan "See all" dalam Row yang sama
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Hair Product",
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
                                      child: Row(
                                        children: [
                                          Text(
                                            "See all",
                                            style: TextStyle(
                                                color: Color(0xFF1B1A55)),
                                          ),
                                          SizedBox(
                                              width:
                                                  4), // Memberikan jarak antara "See all" dan simbol
                                          Icon(
                                            Icons
                                                .arrow_forward, // Menambahkan simbol panah
                                            color: Color(0xFF1B1A55),
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height:
                                        10), // Jarak kecil antara "Hair Product" dan produk
                                // Menampilkan 3 produk dengan Scroll Horizontal
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Menambahkan instance ProductService
                                      FutureBuilder<List<Product>>(
                                        future:
                                            products, // Gunakan Future yang di-cache
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'));
                                          } else if (!snapshot.hasData ||
                                              snapshot.data!.isEmpty) {
                                            return const Center(
                                                child: Text(
                                                    'No Products Available'));
                                          } else {
                                            List<Product> products =
                                                snapshot.data!;

                                            // Menampilkan hanya 3 produk pertama
                                            List<Product> displayedProducts =
                                                products.take(3).toList();

                                            return Row(
                                              children: products
                                                  .take(3)
                                                  .map((product) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      15), // Jarak antar kotak
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // Navigasi ke DetailHaircut dengan mengirim data
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailHaircut(
                                                            title: product.name,
                                                            description: product
                                                                .description,
                                                            sliderImages: product
                                                                .images
                                                                .map((img) =>
                                                                    'assets/images/${img.imageUrl}')
                                                                .toList(),
                                                            galleryImages: product
                                                                .images
                                                                .map((img) =>
                                                                    'assets/images/${img.imageUrl}')
                                                                .toList(),
                                                            faceShapes: [
                                                              product.tipeRambut1 ??
                                                                  '',
                                                              product.tipeRambut2 ??
                                                                  '',
                                                              product.tipeRambut3 ??
                                                                  '',
                                                            ]
                                                                .where((shape) =>
                                                                    shape
                                                                        .isNotEmpty)
                                                                .toList(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: HairProduct(
                                                      imagePath: product
                                                              .images.isNotEmpty
                                                          ? 'assets/images/${product.images.first.imageUrl}'
                                                          : 'assets/images/default_image.png',
                                                      productName: product.name,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hair Cut",
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
                                  child: Row(
                                    children: [
                                      Text(
                                        "See all",
                                        style:
                                            TextStyle(color: Color(0xFF1B1A55)),
                                      ),
                                      SizedBox(
                                          width:
                                              4), // Memberikan jarak antara "See all" dan simbol
                                      Icon(
                                        Icons
                                            .arrow_forward, // Menambahkan simbol panah
                                        color: Color(0xFF1B1A55),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              StatefulBuilder(
                                builder: (context, setState) {
                                  bool isBuzzCutBookmarked = false;
                                  return HaircutItem(
                                    title: 'Buzz Cut',
                                    description:
                                        'Buzz cut adalah gaya rambut sangat pendek yang dicukur merata.',
                                    faceShapes: ['Oval', 'Round', 'Square'],
                                    isBookmarked: isBuzzCutBookmarked,
                                    onBookmarkTap: () {
                                      setState(() {
                                        isBuzzCutBookmarked =
                                            !isBuzzCutBookmarked;
                                      });
                                    },
                                  );
                                },
                              ),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  bool isCrewCutBookmarked = false;
                                  return HaircutItem(
                                    title: 'Crew Cut',
                                    description:
                                        'Crew cut adalah gaya rambut klasik dengan sisi pendek.',
                                    faceShapes: ['Oval', 'Round'],
                                    isBookmarked: isCrewCutBookmarked,
                                    onBookmarkTap: () {
                                      setState(() {
                                        isCrewCutBookmarked =
                                            !isCrewCutBookmarked;
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
