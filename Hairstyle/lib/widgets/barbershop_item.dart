import 'package:flutter/material.dart';

class BarberShopItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const BarberShopItem({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isBookmarked,
    required this.onBookmarkTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            // Bookmark Icon at the top-right corner
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: onBookmarkTap,
                child: Image.asset(
                  isBookmarked
                      ? 'assets/icons/bookmarkcwhite.png'
                      : 'assets/icons/bookmarkcblue.png', // Gambar untuk bookmark tidak terklik
                  width: 28.0,
                  height: 28.0,
                ),
              ),
            ),
            // Text with a semi-transparent black background
            Positioned(
              bottom: 1,
              left: 1,
              right: 1, // Menambah right untuk membuat background penuh
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.5), // Background hitam dengan opacity
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              right: 16,
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Pastikan elemen rata tengah
                children: [
                  Image.asset(
                    'assets/icons/star.jpeg', // Path to star image
                    width: 28.0, // Memperbesar ukuran bintang
                    height: 28.0,
                  ),
                  SizedBox(
                      width: 2.0), // Sesuaikan jarak antara bintang dan rating
                  Text(
                    '4.5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
