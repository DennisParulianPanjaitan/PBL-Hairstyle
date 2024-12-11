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
    // Membuat nama folder dan gambar berdasarkan title
    String imageName = title.toLowerCase().replaceAll(" ", "_");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(
          8), // Mengurangi padding untuk gambar lebih dekat ke border
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
          // Gambar berdasarkan title (contoh: buzzcut akan mengarah ke assets/images/haircut/buzz_cut/...)
          ClipRRect(
            borderRadius: BorderRadius.circular(
                12), // Radius gambar untuk tampilan lebih lembut
            child: Image.asset(
              'assets/images/haircut/$imageName/${imageName}_0.jpg', // Menggunakan $imageName untuk menentukan gambar
              width: 100, // Memperbesar gambar
              height: 110, // Memperbesar gambar
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16), // Jarak lebih besar untuk tulisan
          // Konten
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15), // Menggeser seluruh tulisan
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul (Buzz Cut)
                  Text(
                    title,
                    style: TextStyle(
                      color: isBookmarked ? Colors.white : Color(0xFF1B1A55),
                      fontSize: 20, // Memperbesar tulisan
                      fontWeight: FontWeight.bold, // Membold tulisan
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
                  const SizedBox(height: 8),
                  // Face Shapes
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
