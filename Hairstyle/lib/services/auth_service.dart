import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
// import 'package:multicast_dns/multicast_dns.dart';

class AuthService {
  // 2 unused variables, just ignore them 
  String laptopku = '192.168.0.103';
  String portLaptopku = '3000';

  // var urlList = ['http://localhost', 'http://10.0.2.2/auth'];
  String baseUrl = 'http://192.168.0.100:3000/auth'; // Change this to your server's URL if needed

  void detectPlatform() {
    if (kIsWeb) {
      // print("Running on the web");
      baseUrl = 'http://localhost:3000/auth';
    } else {
      baseUrl = 'http://$laptopku:$portLaptopku/auth';
    }

    // else if (defaultTargetPlatform == TargetPlatform.android) {
    //   // print("Running on Android");
    //   baseUrl = '${urlList[1]}:3000/auth';
    // } else if (defaultTargetPlatform == TargetPlatform.iOS) {}
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    // detectPlatform();
    // baseUrl = 'http://10.0.2.2:3000';
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
     
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getProtectedData(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/protected'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to access protected data: ${response.body}');
    }
  }
}
