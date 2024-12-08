import 'dart:convert';
import 'package:http/http.dart' as http;

class OTPService {
  // Endpoint for sending OTP
  static const String sendOtpUrl = 'http://localhost:3001/otp';
  // Endpoint for verifying OTP
  static const String verifyOtpUrl = 'http://localhost:3001/otp';

  // Send OTP to the backend
  Future<bool> sendOtp(String username, String email) async {
    // try {
      final response = await http.post(
        Uri.parse('$sendOtpUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'email': email}),
      );
      
      // if (response.statusCode == 200) {
      //   return true;
      // } else {
      //   return false;
      // }
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error sending OTP: ${response.body}');
      }
  //   } catch (e) {
  //     // print('Error sending OTP: $e');
  //     return false;
  //   }
  }

  // Verify OTP sent to the email
  // Future<bool> verifyOtp(String username, String email, String otp) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$verifyOtpUrl/verify-otp'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({'username': username, 'email': email, 'otp': otp}),
  //     );
      
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     // print('Error verifying OTP: $e');
  //     return false;
  //   }
  // }
}
