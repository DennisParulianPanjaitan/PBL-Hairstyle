import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/haircut.dart';

class HaircutService {
  static const String _baseUrl = 'https://hairmate.smartrw.my.id/api';

  Future<List<Haircut>> fetchHaircuts() async {
    final url = Uri.parse('$_baseUrl/gethaircut');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load haircuts. Status: ${response.statusCode}');
    }

    // Decoding response body
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Mengakses 'data' yang merupakan sebuah List
    final List<dynamic> haircutsData = jsonResponse['data'];

    // Mengubah list JSON menjadi List<Haircut>
    return haircutsData
        .map((haircutData) => Haircut.fromJson(haircutData))
        .toList();
  }

  Future<List<Haircut>> fetchHaircutsByLikes(int userId) async {
    final url = 'https://hairmate.smartrw.my.id/api/haircuts/liked?user_id=50';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return (responseData['data'] as List)
            .map((item) => Haircut.fromJson(item))
            .toList();
      } else {
        throw Exception(
            'Failed to fetch liked haircuts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to connect to API');
    }
  }
}
