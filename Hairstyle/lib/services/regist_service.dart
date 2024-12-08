import 'dart:convert';
import 'package:http/http.dart' as http;

class OTPService {
  // Endpoint for sending OTP
  static const String sendOtpUrl = 'http://localhost:3001/otp';
  // Endpoint for verifying OTP
  static const String verifyOtpUrl = 'http://localhost:3001/otp';

  // Send OTP to the backend
  Future<bool> sendOtp(String username, String email) async {
      final response = await http.post(
        Uri.parse('$sendOtpUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'email': email}),
      );
  
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error sending OTP: ${response.body}');
      }
  }
}
