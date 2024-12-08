// import 'package:flutter/material.dart';
// import 'login.dart'; // Import login page
// import '../services/regist_service.dart';

// class OtpPage extends StatefulWidget {
//   final String email;
//   const OtpPage({super.key, required this.email});

//   @override
//   _OtpPageState createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   final TextEditingController otpController = TextEditingController();
//   final OTPService _otpService = OTPService();

//   // Verify OTP logic
//   void _verifyOtp() async {
//     String otp = otpController.text;

//     bool verified = await _otpService.verifyOtp(widget.email, otp);

//     if (verified) {
//       // Navigate to login page if OTP is verified
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     } else {
//       // Show error if OTP verification fails
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Invalid OTP')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image and form as before...
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
//                   Text("One-time password"),
//                   // OTP input fields (as before)
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
//                             controller: otpController,
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
//                   ElevatedButton(
//                     onPressed: _verifyOtp,
//                     child: Text("Finish registration"),
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
