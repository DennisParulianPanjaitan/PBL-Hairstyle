import 'package:flutter/material.dart';
import 'package:uts_linkaja/models/haircut.dart';

class HaircutItem extends StatefulWidget {
  final String title;
  final String description;
  final List<String> faceShapes;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final List<HaircutImage>
      images; // Menambahkan properti images untuk menyimpan data gambar

  const HaircutItem({
    Key? key,
    required this.title,
    required this.description,
    required this.faceShapes,
    required this.isBookmarked,
    required this.onBookmarkTap,
    required this.images, // Tambahkan images
  }) : super(key: key);

  @override
  _HaircutItemState createState() => _HaircutItemState();
}

class _HaircutItemState extends State<HaircutItem> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    // Menyimpan status bookmark awal berdasarkan nilai dari widget
    isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil gambar pertama dari list images, atau default jika tidak ada
    // Pastikan gambar ada di folder assets/images/
    final imageUrl = widget.images.isNotEmpty
        ? 'assets/images/${widget.images[0].imageUrl}' // Menggunakan path lokal
        : 'assets/images/photo.png'; // Path default

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
          // Gambar - Menggunakan Image.asset untuk memuat gambar dari folder assets
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl, // Menggunakan path lokal
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
                    widget.title,
                    style: TextStyle(
                      color: isBookmarked ? Colors.white : Color(0xFF1B1A55),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: isBookmarked ? Colors.white : Color(0xFF1B1A55),
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.faceShapes.join("   |   "),
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
          // Padding(
          //   padding: const EdgeInsets.only(top: 18), // Geser ke bawah
          //   child: GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         isBookmarked = !isBookmarked; // Toggle status bookmark
          //       });
          //       widget.onBookmarkTap(); // Memanggil callback dari widget parent
          //     },
          //     child: Image.asset(
          //       isBookmarked
          //           ? 'assets/icons/bookmarkwhite.png'
          //           : 'assets/icons/bookmarkblue.png',
          //       width: 24,
          //       height: 24,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
