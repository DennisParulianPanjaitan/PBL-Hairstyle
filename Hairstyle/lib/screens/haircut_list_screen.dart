import 'package:flutter/material.dart';
import '../models/haircut.dart';
import '../services/haircut_service.dart';

class HaircutListScreen extends StatefulWidget {
  @override
  _HaircutListScreenState createState() => _HaircutListScreenState();
}

class _HaircutListScreenState extends State<HaircutListScreen> {
  final HaircutService _apiService = HaircutService();
  late Future<List<Haircut>> _haircutsFuture;

  int filterId = 1; // ID rambut yang ingin ditampilkan

  @override
  void initState() {
    super.initState();
    _haircutsFuture = _apiService.fetchHaircuts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Hairstyle')),
      body: FutureBuilder<List<Haircut>>(
        future: _haircutsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada produk tersedia'));
          }

          // Filter hanya item dengan ID tertentu
          final haircuts = snapshot.data!;
          final filteredHaircuts =
              haircuts.where((haircut) => haircut.id == filterId).toList();

          if (filteredHaircuts.isEmpty) {
            return Center(child: Text('Produk dengan ID $filterId tidak ditemukan'));
          }

          // Tampilkan hanya item pertama (karena hasilnya satu item setelah filter)
          final haircut = filteredHaircuts.first;

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    haircut.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(haircut.description),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: haircut.images.map((image) {
                      return Image.asset(
                        'assets/images/${image.imageUrl}', // Path ke folder assets
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
