import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:multicast_dns/multicast_dns.dart';

class AuthService {
  String _mdns = '';

  // Fungsi untuk menemukan layanan melalui mDNS
  Future<void> discoverDns() async {
    // Parse the command line arguments.

    const String name = 'http';
    final MDnsClient mdnsClient = MDnsClient();
    // Start the client with default options.
    await mdnsClient.start();
// await for (var ptr in mdnsClient.lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer('http'))) {
//       print('Found service: ${ptr.domainName}');
      
//       // Filter untuk hanya layanan yang kita inginkan
//       if (ptr.domainName == '_http._tcp.local.') {
//         final service = await mdnsClient.lookup<SrvResourceRecord>(ResourceRecordQuery.service(ptr));
        
//         // Ambil informasi layanan dari SRV record
//         for (var srv in service) {
//           if (srv.target.contains('AuthService')) {
//             _baseUrl = 'http://${srv.target}:${srv.port}';
//             print('Base URL set to $_baseUrl');
//             break;
//           }
//         }
//       }
//     }
    // Get the PTR record for the service.
    await for (final PtrResourceRecord ptr in mdnsClient
        .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
      // Use the domainName from the PTR record to get the SRV record,
      // which will have the port and local hostname.
      // Note that duplicate messages may come through, especially if any
      // other mDNS queries are running elsewhere on the machine.
      await for (final SrvResourceRecord srv
          in mdnsClient.lookup<SrvResourceRecord>(
              ResourceRecordQuery.service(ptr.domainName))) {
        // Domain name will be something like "io.flutter.example@some-iphone.local._dartobservatory._tcp.local"
        final String bundleId =
            ptr.domainName; //.substring(0, ptr.domainName.indexOf('@'));
        _mdns = '${srv.target}:${srv.port}';
        print('Dart observatory instance found at '
            '${srv.target}:${srv.port} for "$bundleId".');
      }
    }
    mdnsClient.stop();

    print('Done.');
  }

  // var urlList = ['http://localhost', 'http://10.0.2.2/auth'];
  String baseUrl = ''; // Change this to your server's URL if needed

  Future<void> detectPlatform() async {
    if (kIsWeb) {
      // print("Running on the web");
      baseUrl = 'http://localhost:3000/auth';
    } else {
      await discoverDns();
      baseUrl = 'http://$_mdns/auth';
    }

    // else if (defaultTargetPlatform == TargetPlatform.android) {
    //   // print("Running on Android");
    //   baseUrl = '${urlList[1]}:3000/auth';
    // } else if (defaultTargetPlatform == TargetPlatform.iOS) {}
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    await detectPlatform();
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
