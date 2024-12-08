import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // Endpoint for sending OTP
  String baseUrl = 'http://160.19.166.177:3001/user';

  // Send OTP to the backend
  Future<bool> registrasi(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registrasi'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username, 
        'email': email, 
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error sending OTP: ${response.body}');
    }
  }
}
