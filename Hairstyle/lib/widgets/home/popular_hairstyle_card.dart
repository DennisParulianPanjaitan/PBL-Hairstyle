import 'package:flutter/material.dart';

class PopularHairstyleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  PopularHairstyleCard({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 320,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Color(0xFF1B1A55),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(description, style: TextStyle(color: Colors.white70)),
                  Spacer(),
                  Text("Model Mas Amba", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -72,
          left: 4,
          child: Container(
            width: 120,
            height: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
