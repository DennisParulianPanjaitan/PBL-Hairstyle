import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = "https://hairmate.smartrw.my.id/api/user";

  Future<UserModel?> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final storage = new FlutterSecureStorage();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: 'email', value: data.email);
      // await storage.write(key: 'username', value: data.username);
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
