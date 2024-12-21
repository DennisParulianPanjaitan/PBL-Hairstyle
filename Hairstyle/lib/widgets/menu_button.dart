import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String activeImagePath;
  final String inactiveImagePath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  MenuButton({
    required this.activeImagePath,
    required this.inactiveImagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1B1A55) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF1B1A55)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .center, // Menjaga posisi ikon dan teks di tengah
          children: [
            Image.asset(
              isSelected ? activeImagePath : inactiveImagePath,
              width: 20,
              height: 20,
            ),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Color(0xFF1B1A55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
