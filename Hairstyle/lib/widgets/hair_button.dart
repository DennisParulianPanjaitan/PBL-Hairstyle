import 'package:flutter/material.dart';

class HairButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  HairButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 50, // Menentukan lebar tetap untuk button
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1B1A55) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF1B1A55)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .center, // Mengatur posisi ikon dan teks agar sejajar
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: isSelected ? Colors.white : Color(0xFF1B1A55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
