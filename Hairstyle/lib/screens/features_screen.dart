import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uts_linkaja/screens/detail_haircut.dart';
import 'package:uts_linkaja/screens/detail_product.dart'; // Tambahkan import
import 'package:uts_linkaja/screens/detail_barber.dart'; // Tambahkan import
import 'package:uts_linkaja/models/product.dart'; // Sesuaikan dengan path model Product
import 'package:uts_linkaja/widgets/hairproduct_item.dart';
import '../blocs/features/features_bloc.dart';
import '../blocs/features/features_event.dart';
import '../blocs/features/features_state.dart';
import '../widgets/menu_button.dart';
import '../widgets/haircut_item.dart';
import '../widgets/home/barber_shop_card.dart';
import '../widgets/barbershop_item.dart';
import '../services/haircut_service.dart';
import '../services/product_service.dart';
import '../services/like_service.dart';
import '../services/barbershop_service.dart';
import '../models/haircut.dart';
import '../models/barbershop.dart';

class FeaturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturesBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 50.0),
            BlocBuilder<FeaturesBloc, FeaturesState>(
              builder: (context, state) {
                return Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceAround, // Memberikan jarak antar tombol
                    children: [
                      // Tombol kiri
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0), // Menambahkan padding kiri
                          child: MenuButton(
                            activeImagePath: 'assets/icons/cutp.png',
                            inactiveImagePath: 'assets/icons/cut3.png',
                            label: 'Hair Cut',
                            isSelected: state.currentTabIndex == 0,
                            onTap: () => context
                                .read<FeaturesBloc>()
                                .add(SelectTabEvent(0)),
                          ),
                        ),
                      ),
                      // Tombol tengah dengan sedikit jarak di tengah
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0), // Sedikit jarak antar tombol
                          child: MenuButton(
                            activeImagePath: 'assets/icons/foamp.png',
                            inactiveImagePath: 'assets/icons/foamb.png',
                            label: 'Hair Product',
                            isSelected: state.currentTabIndex == 1,
                            onTap: () => context
                                .read<FeaturesBloc>()
                                .add(SelectTabEvent(1)),
                          ),
                        ),
                      ),
                      // Tombol kanan
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0), // Menambahkan padding kanan
                          child: MenuButton(
                            activeImagePath: 'assets/icons/Locationp.png',
                            inactiveImagePath: 'assets/icons/Locationb.png',
                            label: 'BarberShop',
                            isSelected: state.currentTabIndex == 2,
                            onTap: () => context
                                .read<FeaturesBloc>()
                                .add(SelectTabEvent(2)),
                          ),
                        ),
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
                          context, state.bookmarkedProducts);
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
  Widget _buildHairCutTab(BuildContext context, Set<int> bookmarks) {
    final HaircutService haircutService = HaircutService();

    return FutureBuilder<List<Haircut>>(
      future: haircutService.fetchHaircuts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Failed to load liked hairstyles: ${snapshot.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No liked hairstyles available.'));
        } else {
          final haircutList = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: haircutList.length,
                  itemBuilder: (context, index) {
                    final haircut = haircutList[index];

                    // Kombinasikan faceShapes dari haircut
                    final faceShapes = [
                      haircut.faceShape,
                      haircut.faceShape2,
                      haircut.faceShape3,
                    ]
                        .where((shape) => shape != null)
                        .toList(); // Filter null values

                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman detail
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailHaircut(
                              title: haircut.name,
                              description: haircut.description,
                              sliderImages: haircut.images
                                  .map((image) =>
                                      'assets/images/${image.imageUrl}')
                                  .toList(),
                              galleryImages: haircut.images
                                  .map((image) =>
                                      'assets/images/${image.imageUrl}')
                                  .toList(),
                              faceShapes: faceShapes.cast<String>(),
                            ),
                          ),
                        );
                      },
                      child: HaircutItem(
                        title: haircut.name,
                        description: haircut.description,
                        faceShapes:
                            faceShapes.cast<String>(), // Data faceShapes
                        isBookmarked: bookmarks.contains(haircut.id),
                        onBookmarkTap: () {
                          Set<int> modifiableBookmarks =
                              Set<int>.from(bookmarks);
                          if (modifiableBookmarks.contains(haircut.id)) {
                            modifiableBookmarks.remove(haircut.id);
                            LikeService().deleteUserLike(haircut.id);
                          } else {
                            modifiableBookmarks.add(haircut.id);
                            LikeService()
                                .setUserLike(50, 'haircut', haircut.id);
                          }
                        },
                        images: haircut.images,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Tab HairProduct dengan navigasi ke DetailProduct
  Widget _buildHairProductTab(BuildContext context, Set<int> bookmarks) {
    final productService =
        ProductService(); // Membuat instance dari ProductService

    return FutureBuilder<List<Product>>(
      future: productService.fetchProducts(), // Mengambil data produk
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Products Available'));
        } else {
          List<Product> products = snapshot.data!;

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        builder: (context) => DetailProduct(
                          title: item.name,
                          description: item.description,
                          sliderImages: item.images
                              .map((img) => 'assets/images/${img.imageUrl}')
                              .toList(),
                          galleryImages: item.images
                              .map((img) => 'assets/images/${img.imageUrl}')
                              .toList(),
                          faceShapes: [
                            item.tipeRambut1 ?? '',
                            item.tipeRambut2 ?? '',
                            item.tipeRambut3 ?? '',
                          ].where((shape) => shape.isNotEmpty).toList(),
                        ),
                      ),
                    );
                  },
                  child: HairProductItem(
                    title: item.name,
                    imagePath:
                        'assets/images/${item.images.first.imageUrl}', // Menampilkan gambar pertama sebagai thumbnail
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
      },
    );
  }

  // // Tab BarberShop dengan navigasi ke DetailBarber
  Widget _buildBarberShopTab(BuildContext context, Set<int> bookmarks) {
    final barberShopService =
        BarberShopService(); // Membuat instance dari BarberShopService

    return FutureBuilder<List<Barbershop>>(
      future: barberShopService.fetchBarbershop(), // Mengambil data barber shop
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Menunggu data
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  'Error: ${snapshot.error}')); // Menampilkan error jika ada
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
                  'No Barbershops Available')); // Menampilkan pesan jika data kosong
        } else {
          List<Barbershop> barbershops = snapshot.data!;

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 1.4, // Proporsi lebih tinggi untuk estetika
              ),
              itemCount: barbershops.length,
              itemBuilder: (context, index) {
                final item = barbershops[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman DetailBarber
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBarber(
                          title: item.name,
                          description: item.description,
                          sliderImages: item.images
                              .map((img) => 'assets/images/${img.imageUrl}')
                              .toList(), // Menggunakan gambar dari barbershop
                          galleryImages: item.images
                              .map((img) => 'assets/images/${img.imageUrl}')
                              .toList(), // Menggunakan gambar untuk galeri
                          priceRange: item.rangeHarga ??
                              "N/A", // Menampilkan range harga
                        ),
                      ),
                    );
                  },
                  child: BarberShopCard(
                    name: item.name, // Menampilkan nama barbershop
                    price: item.rangeHarga ?? "N/A", // Menampilkan range harga
                    rating: item.rating, // Menampilkan range harga
                    imagePath:
                        'assets/images/${item.images.first.imageUrl}', // Menampilkan gambar pertama sebagai thumbnail
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
