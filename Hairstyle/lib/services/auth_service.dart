import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  // final String baseUrl = "http://127.0.0.1:8000/api/user";
  final String baseUrl = "https://hairmate.smartrw.my.id/api/user";

  Future<UserModel?> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<bool> register(Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl/daftar");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
