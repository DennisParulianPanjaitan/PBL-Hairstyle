import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/barbershop.dart';

class BarberShopService {
  static const String _baseUrl =
      'https://hairmate.smartrw.my.id/api'; // Ganti dengan IP server Anda

  Future<List<Barbershop>> fetchBarbershop() async {
    final url = Uri.parse('$_baseUrl/getbarbershop'); // URL API Anda

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load products. Status: ${response.statusCode}');
    }

    final jsonResponse = json.decode(response.body);
    final List<dynamic> data = jsonResponse['data'];

    // Memetakan data ke List of Product
    return data.map((barbershopData) {
      return Barbershop.fromJson(barbershopData);
    }).toList();
  }
}
