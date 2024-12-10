// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'login.dart'; // Import halaman Create New Password
// import '../services/user_services.dart';

// class OtpPage extends StatefulWidget {
//   final String email;
//   final String username;
//   const OtpPage({super.key, required this.username, required this.email});

//   @override
//   State<StatefulWidget> createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   // final TextEditingController otpController = TextEditingController();
//   final List<TextEditingController> otpControllers =
//       List.generate(4, (_) => TextEditingController());
//   final UserServices _otpService = UserServices();
//   String _errorMessage = '';

//   // Verify OTP logic
//   void _verifyOtp() async {
//     String otp = otpControllers.map((controller) => controller.text).join();
//     setState(() {
//       _errorMessage = '';
//     });

//     try {
//       bool verified =
//           await _otpService.verifyOtp(widget.username, widget.email, otp);

//       if (verified) {
//         // Navigate to login page if OTP is verified
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginPage()),
//         );
//       } else {
//         // Show error if OTP verification fails
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   SnackBar(content: Text('Invalid OTP')),
//         // );
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//       });
//       _showDialogPop(_errorMessage);
//     }
//   }

//   void _showDialogPop(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Registrasi Gagal'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Menutup dialog
//               },
//               child: Text('Mengerti'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           ColorFiltered(
//             colorFilter: ColorFilter.mode(
//               Colors.grey, // Apply grayscale effect
//               BlendMode.saturation,
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image:
//                       AssetImage('assets/images/verification_background.jpeg'),
//                   fit: BoxFit.contain,
//                   alignment: Alignment.topCenter,
//                 ),
//               ),
//             ),
//           ), // Background image
//           // White container for verification form
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.36,
//               padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "One-time password",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1B1A55),
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "We have sent the OTP to af******@gmail.com",
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 16),
//                   // Code input fields
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(4, (index) {
//                       return Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Center(
//                           child: TextField(
//                             controller: otpControllers[index],
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 24),
//                             keyboardType: TextInputType.number,
//                             maxLength: 1,
//                             decoration: InputDecoration(
//                               counterText: "",
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Send OTP again in 00:45",
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 16),
//                   // Verification Button
//                   ElevatedButton(
//                     onPressed: _verifyOtp,
//                     // () {
//                     //   // Navigasi ke halaman Create New Password
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(builder: (context) => LoginPage()),
//                     //   );
//                     // },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF1B1A55),
//                       padding:
//                           EdgeInsets.symmetric(vertical: 14, horizontal: 64),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: Text(
//                       "Finish registration",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
