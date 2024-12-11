import 'package:flutter/material.dart';
import 'package:uts_linkaja/screens/detail_haircut.dart';
import 'package:uts_linkaja/screens/detail_product.dart';
import 'package:uts_linkaja/screens/detail_barber.dart'; // Tambahkan jika ada
import '../widgets/menu_button.dart'; // Tambahkan jika ada

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _currentIndex = 0;

  // Variabel untuk menyimpan status bookmark secara terpisah
  Set<int> bookmarkedHaircuts = {};
  Set<int> bookmarkedProducts = {};
  Set<int> bookmarkedBarbershops = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50.0),
          Container(
            height: 60,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuButton(
                    activeImagePath: 'assets/icons/cutp.png',
                    inactiveImagePath: 'assets/icons/cut3.png',
                    label: 'Hair Cut',
                    isSelected: _currentIndex == 0,
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),
                  MenuButton(
                    activeImagePath: 'assets/icons/foamp.png',
                    inactiveImagePath: 'assets/icons/foamb.png',
                    label: 'Hair Product',
                    isSelected: _currentIndex == 1,
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),
                  MenuButton(
                    activeImagePath: 'assets/icons/Locationp.png',
                    inactiveImagePath: 'assets/icons/Locationb.png',
                    label: 'BarberShop',
                    isSelected: _currentIndex == 2,
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                // _buildHairCutTab(),
                // _buildHairProductTab(),
                // _buildBarberShopTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildHairCutTab() {
  //   return ListView.builder(
  //     scrollDirection: Axis.vertical,
  //     itemCount: 5,
  //     itemBuilder: (context, index) {
  //       return _buildHairCutItem(
  //         context,
  //         index,
  //         'assets/images/photo.png',
  //         "Buzzcut",
  //         "Buzzcut adalah gaya rambut sangat pendek yang dicukur merata diseluruh kepala",
  //       );
  //     },
  //   );
  // }

  // Widget _buildHairProductTab() {
  //   return GridView.builder(
  //     padding: EdgeInsets.all(16.0),
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 10.0,
  //       mainAxisSpacing: 10.0,
  //       childAspectRatio: 0.7,
  //     ),
  //     itemCount: 4,
  //     itemBuilder: (context, index) {
  //       return _buildProductItem(
  //         index,
  //         'assets/images/hair_product.jpeg',
  //         "Hair Powder",
  //       );
  //     },
  //   );
  // }

  Widget _buildBarberShopTab() {
    return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return _buildBarberShopItem(
          index,
          'assets/images/barbershop.jpeg',
          "GoodFellas",
          "Rp 20.000 - 500.000",
        );
      },
    );
  }

  // Widget _buildHairCutItem(BuildContext context, int index, String imagePath,
  //     String name, String desc) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           // builder: (context) => DetailHaircut(),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.only(left: 22.0, right: 22.0, top: 10.0),
  //       padding: const EdgeInsets.all(12),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(16),
  //         border: Border.all(
  //           color: Color(0xFF1B1A55),
  //           width: 2,
  //         ),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Stack(
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(8),
  //                     child: Image.asset(
  //                       imagePath,
  //                       width: 90,
  //                       height: 90,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 16),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           name,
  //                           style: TextStyle(
  //                             color: Color(0xFF1B1A55),
  //                             fontSize: 17,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const SizedBox(height: 8),
  //                         Text(
  //                           desc,
  //                           style: TextStyle(
  //                             color: Color(0xFF1B1A55),
  //                             fontSize: 11,
  //                           ),
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 3,
  //                           textAlign: TextAlign.justify,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Positioned(
  //                 top: -15,
  //                 right: -15,
  //                 child: IconButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       if (bookmarkedHaircuts.contains(index)) {
  //                         bookmarkedHaircuts.remove(index);
  //                       } else {
  //                         bookmarkedHaircuts.add(index);
  //                       }
  //                     });
  //                   },
  //                   icon: Icon(
  //                     bookmarkedHaircuts.contains(index)
  //                         ? Icons.bookmark
  //                         : Icons.bookmark_border,
  //                     color: bookmarkedHaircuts.contains(index)
  //                         ? Color(0xFF007BFF)
  //                         : Color(0xFF1B1A55),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 16),
  //           const Text(
  //             'Oval   |   Round   |   Square',
  //             style: TextStyle(
  //               color: Color(0xFF1B1A55),
  //               fontSize: 14,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildProductItem(int index, String imagePath, String productName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProduct(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    imagePath,
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      bookmarkedProducts.contains(index)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: bookmarkedProducts.contains(index)
                          ? Colors.amber
                          : Color(0xFF1B1A55),
                    ),
                    onPressed: () {
                      setState(() {
                        if (bookmarkedProducts.contains(index)) {
                          bookmarkedProducts.remove(index);
                        } else {
                          bookmarkedProducts.add(index);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                productName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Color(0xFF1B1A55),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarberShopItem(
      int index, String imagePath, String name, String priceRange) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBarber(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  color: Color(0xFF1B1A55),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              priceRange,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
