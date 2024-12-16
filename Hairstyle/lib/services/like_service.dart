import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/likes.dart';

class LikeService {
  static const String _baseUrl = 'https://hairmate.smartrw.my.id/api';

  // Menambahkan atau menghapus like
  Future<void> setUserLike(int userId, String entityType, int entityId) async {
    final url = Uri.parse('$_baseUrl/setuserlike');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': userId,
        'entity_type': entityType,
        'entity_id': entityId,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
          'Failed to set user like. Status: ${response.statusCode}, Body: ${response.body}');
    }
  }

  // Mendapatkan daftar like berdasarkan user_id
  Future<List<Like>> getUserLike(int userId) async {
    final url = Uri.parse('$_baseUrl/getuserlike?id=$userId');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load user likes. Status: ${response.statusCode}, Body: ${response.body}');
    }

    final jsonResponse = json.decode(response.body);

    // Validasi struktur response
    if (jsonResponse['data'] == null || jsonResponse['data'] is! List) {
      throw Exception('Unexpected response structure: ${response.body}');
    }

    final List<dynamic> data = jsonResponse['data'];

    // Ubah response menjadi list of Like
    return data.map((likeData) => Like.fromJson(likeData)).toList();
  }

  // Menghapus like berdasarkan ID like
  Future<void> deleteUserLike(int likeId) async {
    final url = Uri.parse('$_baseUrl/deleteuserlike');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': likeId}),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to delete user like. Status: ${response.statusCode}, Body: ${response.body}');
    }
  }
}
