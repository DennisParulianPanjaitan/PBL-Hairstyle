import 'package:flutter/material.dart';
import '../models/haircut.dart';

class HaircutItem extends StatelessWidget {
  final String title;
  final String description;
  final List<HaircutImage> images;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const HaircutItem({
    Key? key,
    required this.title,
    required this.description,
    required this.images,
    required this.isBookmarked,
    required this.onBookmarkTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ambil URL gambar pertama, atau gunakan placeholder jika tidak ada gambar
    final String imageUrl = images.isNotEmpty
        ? 'assets/images//${images.first.imageUrl}'
        : 'assets/images/placeholder.png';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isBookmarked
            ? Color(0xFF1B1A55)
            : Colors.white, // Background berubah jika di-bookmark
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF1B1A55),
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar dari database atau placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: 100,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Konten
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul
                  Text(
                    title,
                    style: TextStyle(
                      color: isBookmarked ? Colors.white : Color(0xFF1B1A55),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Deskripsi
                  Text(
                    description,
                    style: TextStyle(
                      color: isBookmarked ? Colors.white : Color(0xFF1B1A55),
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          // Bookmark Icon
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: GestureDetector(
              onTap: onBookmarkTap,
              child: Image.asset(
                isBookmarked
                    ? 'assets/icons/bookmarkwhite.png'
                    : 'assets/icons/bookmarkblue.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
