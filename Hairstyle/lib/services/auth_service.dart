// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';

// class AuthService {
//   // var urlList = ['http://localhost', 'http://10.0.2.2/auth'];
//   // Endpoint untuk mengakses server
//   String baseUrl = 'http://160.19.166.177:3001/auth';

//   Future<Map<String, dynamic>> login(String username, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'username': username, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to login: ${response.body}');
//     }
//   }

//   Future<Map<String, dynamic>> getProtectedData(String token) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/protected'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': token,
//       },
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to access protected data: ${response.body}');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/register.dart';
import '../models/user_model.dart';

class AuthService {
  final String _baseUrl = 'https://tomascan.nurulmustofa.my.id/api';

  Future<UserModel> register(RegisterRequest request) async {
    final url = Uri.parse('$_baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Periksa apakah response memiliki struktur yang diharapkan
      if (data['user'] != null) {
        return UserModel.fromJson(data['user']);
      } else {
        throw Exception(data['message'] ?? 'Unexpected API response format');
      }
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to register');
    }
  }
}
