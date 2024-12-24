import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/home/popular_hairstyle_card.dart';
import '../widgets/home/barber_shop_card.dart'; // Import BarberShopCard
import '../widgets/home/hair_type_card.dart'; // Import HairTypeCard
import '../widgets/home/hair_product_card.dart'; // Import HairTypeCar
import '../widgets/home/hair_style_card.dart'; // Import HairTypeCard
import 'detail_haircut.dart';

import 'detail_barber.dart';
import 'package:uts_linkaja/services/product_service.dart';
import 'package:uts_linkaja/models/product.dart';

import 'package:uts_linkaja/services/haircut_service.dart';
import 'package:uts_linkaja/models/haircut.dart';

import 'package:uts_linkaja/services/barbershop_service.dart';
import 'package:uts_linkaja/models/barbershop.dart';

import 'profile_screen.dart';

final List<Map<String, String>> hairstyles = [
  {
    'title': 'Buzz Cut',
    'description':
        'A very short, even cut all over the head. Easy to maintain, clean, and masculine, suitable for various face shapes.',
    'imagePath': 'assets/images/masamba.jpeg',
  },
  {
    'title': 'Undercut',
    'description':
        'Short sides with longer top. Popular and modern, giving a stylish and edgy look.',
    'imagePath': 'assets/images/masamba2.jpeg',
  },
  {
    'title': 'Two Block',
    'description':
        'Long, voluminous top with short sides and back. Perfect for a trendy and cool look.',
    'imagePath': 'assets/images/masamba4.jpeg',
  },
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> products;
  late Future<List<Haircut>> haircuts;
  late Future<List<Barbershop>> barbershop;

  int currentPage = 0;
  ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController(initialPage: 100);
  double _headerOpacity = 1.0; // Opacity initial header
  Timer? _timer;

  String username = 'Dennis';
  String email = '';
  String ppPath = '';

  // Fungsi untuk mengambil data pengguna
  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Bro';
      email = prefs.getString('email') ?? 'Unknown';
      ppPath = prefs.getString('profile_picture_url') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    products = ProductService().fetchProducts(); // Simpan Future di variabel
    haircuts = HaircutService().fetchHaircuts(); // Mengambil data hairstyle
    barbershop =
        BarberShopService().fetchBarbershop(); // Mengambil data hairstyle
    getUserData();
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
                              "Hi, $username",
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(), // Make sure ProfileScreen is imported
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(ppPath) as ImageProvider
                              // ppPath.isEmpty
                              //   ? FileImage(File(ppPath))
                              //   : AssetImage('assets/images/home_profile.jpeg') as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),

                // Kotak scrollable untuk 3 menu
                SizedBox(
                  // height: 1500, // Atur tinggi tetap untuk kotak ini
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
                              "Popular Haircut",
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
                                  currentPage = index %
                                      3; // This keeps cycling between 0 to 4
                                });
                              },
                              itemCount: 3 * 1000, // Infinite loop simulation
                              itemBuilder: (context, index) {
                                final itemIndex = index % 3;
                                final hairstyle = hairstyles[
                                    itemIndex]; // Get data for the current page

                                return PopularHairstyleCard(
                                  title: hairstyle[
                                      'title']!, // Access title from the list
                                  description: hairstyle['description']!,
                                  imagePath: hairstyle['imagePath']!,
                                  // Access description from the list
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
                                3,
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
                            child: FutureBuilder<List<Barbershop>>(
                              future:
                                  barbershop, // Future yang berisi List<Barbershop>
                              builder: (context, snapshot) {
                                // Menangani state dari Future
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child:
                                          CircularProgressIndicator()); // Menunggu data
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          'Error: ${snapshot.error}')); // Menampilkan error jika ada
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                      child: Text(
                                          'No barbershops available')); // Jika tidak ada data
                                } else {
                                  final barberShops = snapshot
                                      .data!; // Mendapatkan data barbershop dari snapshot

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(left: 18),
                                    itemCount: barberShops.length,
                                    itemBuilder: (context, index) {
                                      final barber = barberShops[
                                          index]; // Mendapatkan object Barbershop

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailBarber(
                                                title: barber.name,
                                                description: barber.description,
                                                sliderImages: barber.images
                                                    .map((img) =>
                                                        'assets/images/${img.imageUrl}')
                                                    .toList(), // Menggunakan gambar dari barbershop
                                                galleryImages: barber.images
                                                    .map((img) =>
                                                        'assets/images/${img.imageUrl}')
                                                    .toList(), // Menggunakan gambar untuk galeri
                                                priceRange: barber.rangeHarga ??
                                                    "N/A", // Menampilkan range harga
                                              ),
                                            ),
                                          );
                                        },
                                        child: BarberShopCard(
                                          name: barber
                                              .name, // Mengakses properti name
                                          price: barber.rangeHarga ??
                                              'N/A', // Mengakses rangeHarga dan menangani null
                                          rating: barber.rating,
                                          imagePath: barber.images.isNotEmpty
                                              ? 'assets/images/' +
                                                  barber.images[0]
                                                      .imageUrl // Menambahkan path sebelum URL gambar
                                              : 'assets/images/default_barbershop.png', // Path default jika tidak ada gambar
                                        ),
                                      );
                                    },
                                  );
                                }
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
                              FutureBuilder<List<Haircut>>(
                                future: haircuts, // Mengambil data hairstyle
                                builder: (context, snapshot) {
                                  // Memeriksa status koneksi data
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        'Failed to load hairstyles: ${snapshot.error}',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Center(
                                        child:
                                            Text('No hairstyles available.'));
                                  } else {
                                    final haircutList = snapshot
                                        .data!; // Data yang diambil dari API

                                    // Batasi hanya 3 item pertama
                                    final limitedHaircutList =
                                        haircutList.take(3).toList();

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: limitedHaircutList.length,
                                      itemBuilder: (context, index) {
                                        final haircut =
                                            limitedHaircutList[index];

                                        // Gabungkan faceShape, faceShape2, dan faceShape3
                                        final faceShapes = [
                                          haircut.faceShape,
                                          haircut.faceShape2,
                                          haircut.faceShape3,
                                        ]
                                            .where((shape) => shape != null)
                                            .toList();

                                        return GestureDetector(
                                          onTap: () {
                                            // Navigasi ke halaman detail
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailHaircut(
                                                  title: haircut.name,
                                                  description:
                                                      haircut.description,
                                                  sliderImages: haircut.images
                                                      .map((image) =>
                                                          'assets/images/${image.imageUrl}')
                                                      .toList(),
                                                  galleryImages: haircut.images
                                                      .map((image) =>
                                                          'assets/images/${image.imageUrl}')
                                                      .toList(),
                                                  faceShapes: faceShapes.cast<
                                                      String>(), // Data faceShapes
                                                ),
                                              ),
                                            );
                                          },
                                          child: HaircutItem(
                                            title: haircut.name,
                                            description: haircut.description,
                                            faceShapes: faceShapes.cast<
                                                String>(), // Data faceShapes
                                            isBookmarked:
                                                false, // Status bookmark, bisa disesuaikan
                                            onBookmarkTap: () {
                                              print(
                                                  'Bookmark tapped for: ${haircut.name}');
                                            },
                                            images: haircut
                                                .images, // Mengirim images dari database
                                          ),
                                        );
                                      },
                                    );
                                  }
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
