import 'package:flutter/material.dart';

class HairTypeCard extends StatelessWidget {
  final String title;
  final String imagePath;

  HairTypeCard(this.title, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
        ),
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(vertical: 6),
          color: Colors.black.withOpacity(0.5),
          child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
