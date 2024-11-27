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
        width: 115, // Menentukan lebar tetap untuk button
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1B1A55) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF1B1A55)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .center, // Mengatur posisi ikon dan teks agar sejajar
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
                fontSize: 11,
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
