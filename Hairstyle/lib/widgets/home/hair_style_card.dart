import 'package:flutter/material.dart';

class HaircutItem extends StatelessWidget {
  final String title;
  final String description;
  final List<String> faceShapes;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const HaircutItem({
    Key? key,
    required this.title,
    required this.description,
    required this.faceShapes,
    required this.isBookmarked,
    required this.onBookmarkTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(8), // Mengatur padding dalam item
      decoration: BoxDecoration(
        color: isBookmarked ? Color(0xFF1B1A55) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF1B1A55),
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/photo.png', // Path gambar
              width: 100,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16), // Jarak antara gambar dan teks
          // Konten
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15), // Geser konten ke bawah
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isBookmarked ? Colors.white : Color(0xFF1B1A55),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: isBookmarked ? Colors.white : Color(0xFF1B1A55),
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    faceShapes.join("   |   "),
                    style: TextStyle(
                      color: isBookmarked ? Colors.white : Color(0xFF1B1A55),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bookmark Icon
          Padding(
            padding: const EdgeInsets.only(top: 18), // Geser ke bawah
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
