import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uts_linkaja/screens/detail_haircut.dart';
import 'package:uts_linkaja/screens/detail_product.dart'; // Tambahkan import
import 'package:uts_linkaja/screens/detail_barber.dart'; // Tambahkan import
import '../blocs/features/features_bloc.dart';
import '../blocs/features/features_event.dart';
import '../blocs/features/features_state.dart';
import '../widgets/menu_button.dart';
import '../widgets/haircut_item.dart';
import '../widgets/hairproduct_item.dart';
import '../widgets/barbershop_item.dart';
import '../widgets/data/mock_haircuts.dart';

class FeaturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturesBloc(),
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50.0),
            BlocBuilder<FeaturesBloc, FeaturesState>(
              builder: (context, state) {
                return Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MenuButton(
                        activeImagePath: 'assets/icons/cutp.png',
                        inactiveImagePath: 'assets/icons/cut3.png',
                        label: 'Hair Cut',
                        isSelected: state.currentTabIndex == 0,
                        onTap: () =>
                            context.read<FeaturesBloc>().add(SelectTabEvent(0)),
                      ),
                      MenuButton(
                        activeImagePath: 'assets/icons/foamp.png',
                        inactiveImagePath: 'assets/icons/foamb.png',
                        label: 'Hair Product',
                        isSelected: state.currentTabIndex == 1,
                        onTap: () =>
                            context.read<FeaturesBloc>().add(SelectTabEvent(1)),
                      ),
                      MenuButton(
                        activeImagePath: 'assets/icons/Locationp.png',
                        inactiveImagePath: 'assets/icons/Locationb.png',
                        label: 'BarberShop',
                        isSelected: state.currentTabIndex == 2,
                        onTap: () =>
                            context.read<FeaturesBloc>().add(SelectTabEvent(2)),
                      ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<FeaturesBloc, FeaturesState>(
                builder: (context, state) {
                  switch (state.currentTabIndex) {
                    case 0:
                      return _buildHairCutTab(
                          context, state.bookmarkedHaircuts);
                    case 1:
                      return _buildHairProductTab(
                          context, state.bookmarkedProducts);
                    case 2:
                      return _buildBarberShopTab(
                          context, state.bookmarkedBarbershops);
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tab HairCut sudah ada
// Tab HairCut menggunakan data dari mock_haircuts.dart
  Widget _buildHairCutTab(BuildContext context, Set<int> bookmarks) {
    return ListView.builder(
      itemCount:
          haircuts.length, // Gantilah dengan data dari mock_haircuts.dart
      itemBuilder: (context, index) {
        final item =
            haircuts[index]; // Data gaya rambut dari mock_haircuts.dart
        return GestureDetector(
          onTap: () {
            // Navigasi ke halaman DetailHaircut dengan data dari mock_haircuts.dart
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailHaircut(
                  title: item["title"] as String,
                  description: item["description"] as String,
                  sliderImages: item["sliderImages"] as List<String>,
                  galleryImages: item["galleryImages"] as List<String>,
                  faceShapes: item["faceShapes"] as List<String>,
                ),
              ),
            );
          },
          child: HaircutItem(
            title: item["title"] as String,
            description: item["description"] as String,
            faceShapes: item["faceShapes"] as List<String>,
            isBookmarked: bookmarks.contains(index),
            onBookmarkTap: () {
              context
                  .read<FeaturesBloc>()
                  .add(ToggleBookmarkEvent(index, "HairCut"));
            },
          ),
        );
      },
    );
  }

  // Tab HairProduct dengan navigasi ke DetailProduct
  Widget _buildHairProductTab(BuildContext context, Set<int> bookmarks) {
    final List<Map<String, dynamic>> products = [
      {
        "title": "Hair Powder",
        "image":
            "assets/images/hair_powder.png", // Ganti path sesuai file gambar kedua
        "isBookmarked": false,
      },
      {
        "title": "Hair Clay",
        "image": "assets/images/hair_clay.png", // Ganti sesuai kebutuhan
        "isBookmarked": false,
      },
      {
        "title": "Pomade",
        "image": "assets/images/hair_pomade.png", // Ganti sesuai kebutuhan
        "isBookmarked": false,
      },
      {
        "title": "Hair Spray",
        "image": "assets/images/hair_clay.png", // Ganti sesuai kebutuhan
        "isBookmarked": false,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75, // Proporsi lebih tinggi untuk estetika
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman DetailProduct
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailProduct(),
                ),
              );
            },
            child: HairProductItem(
              title: item["title"] as String,
              imagePath: item["image"] as String,
              isBookmarked: bookmarks.contains(index),
              onBookmarkTap: () {
                context
                    .read<FeaturesBloc>()
                    .add(ToggleBookmarkEvent(index, "HairProduct"));
              },
            ),
          );
        },
      ),
    );
  }

  // Tab BarberShop dengan navigasi ke DetailBarber
  Widget _buildBarberShopTab(BuildContext context, Set<int> bookmarks) {
    final List<Map<String, dynamic>> barbershops = [
      {
        "title": "GoodFellas",
        "description": "Rp 20.000 - 500.000",
        "imagePath": "assets/images/barbershop.jpeg", // Path to the image
        "isBookmarked": false,
      },
      {
        "title": "GoodFellas",
        "description": "Rp 20.000 - 500.000",
        "imagePath": "assets/images/barbershop.jpeg", // Path to the image
        "isBookmarked": false,
      },
    ];

    return ListView.builder(
      itemCount: barbershops.length,
      itemBuilder: (context, index) {
        final item = barbershops[index];
        return GestureDetector(
          onTap: () {
            // Navigasi ke halaman DetailBarber
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailBarber(),
              ),
            );
          },
          child: BarberShopItem(
            title: item["title"] as String,
            description: item["description"] as String,
            imagePath: item["imagePath"] as String,
            isBookmarked: bookmarks.contains(index),
            onBookmarkTap: () {
              context
                  .read<FeaturesBloc>()
                  .add(ToggleBookmarkEvent(index, "BarberShop"));
            },
          ),
        );
      },
    );
  }
}
