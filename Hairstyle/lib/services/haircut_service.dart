import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/haircut.dart';

class HaircutService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Haircut>> fetchHaircuts() async {
    final url = Uri.parse('$_baseUrl/gethaircut');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load haircuts. Status: ${response.statusCode}');
    }

    final jsonResponse = json.decode(response.body);
    final Map<String, dynamic> data = jsonResponse['data'];

    // Ubah map menjadi list of Haircut
    return data.values.map((haircutData) {
      return Haircut.fromJson(haircutData);
    }).toList();
  }
}
