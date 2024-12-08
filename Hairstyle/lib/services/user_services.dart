import 'dart:convert';
import 'package:http/http.dart' as http;

class UserServices {
  // Endpoint for sending OTP
  String baseUrl = 'http://localhost:3001/otp';

  // Send OTP to the backend
  Future<Map<String, dynamic>> updateUser(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
  Future<bool> deactivateUser(String username, String email) async {
      final response = await http.post(
        Uri.parse('$baseUrl/deactivate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'email': email}),
      );
      
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error sending OTP: ${response.body}');
      }
  }

  // Verify OTP sent to the email
  Future<bool> verifyOtp(String username, String email, String otp) async {
    // try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'email': email, 'otp': otp}),
      );
      
      // if (response.statusCode == 200) {
      //   return true;
      // } else {
      //   return false;
      // }
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error verifying OTP: ${response.body}');
      }
    // } catch (e) {
    //   // print('Error verifying OTP: $e');
    //   return false;
    // }
  }
}
