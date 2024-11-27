import 'package:flutter/material.dart';

class DetailHaircut extends StatelessWidget {
  const DetailHaircut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DetailHaircuttes"),
        backgroundColor: Color(0xFF1B1A55),
      ),
      body: Center(
        child: Text(
          "DetailHaircuttes Page",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
