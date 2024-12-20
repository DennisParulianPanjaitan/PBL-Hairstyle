import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _apiService = ProductService();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture =
        _apiService.fetchProducts(); // Memanggil API untuk mendapatkan data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Produk')),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada produk tersedia'));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.description),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: product.images.map((image) {
                          // Periksa apakah `imageUrl` adalah path relatif ke assets
                          String assetPath = 'assets/images/${image.imageUrl}';
                          return Image.asset(
                            assetPath, // Menggunakan Image.asset untuk gambar lokal
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (product.tipeRambut1 != null)
                        Text('Tipe 1: ${product.tipeRambut1}'),
                      if (product.tipeRambut2 != null)
                        Text('Tipe 2: ${product.tipeRambut2}'),
                      if (product.tipeRambut3 != null)
                        Text('Tipe 3: ${product.tipeRambut3}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
