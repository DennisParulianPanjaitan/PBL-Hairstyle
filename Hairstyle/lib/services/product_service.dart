import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String _baseUrl =
      'http://127.0.0.1:8000/api'; // Ganti dengan IP server Anda

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$_baseUrl/getproduct'); // URL API Anda

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load products. Status: ${response.statusCode}');
    }

    final jsonResponse = json.decode(response.body);
    final List<dynamic> data = jsonResponse['data'];

    // Memetakan data ke List of Product
    return data.map((productData) {
      return Product.fromJson(productData);
    }).toList();
  }
}
