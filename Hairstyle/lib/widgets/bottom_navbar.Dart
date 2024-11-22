import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 30.0,
      child: BottomAppBar(
        color: Colors.white,
        elevation: 0.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                onItemTapped(0);
              },
              icon: selectedIndex == 0
                  ? Image.asset('assets/icons/HomeBold.png', width: 24.0, height: 24.0)
                  : Image.asset('assets/icons/HomeOut.png', width: 24.0, height: 24.0),
            ),
            IconButton(
              onPressed: () {
                onItemTapped(1);
              },
              icon: selectedIndex == 1
                  ? Image.asset('assets/icons/CategoryBold.png', width: 24.0, height: 24.0)
                  : Image.asset('assets/icons/CategoryOut.png', width: 24.0, height: 24.0),
            ),
            SizedBox(width: 56.0), // To make space for the floating action button
            IconButton(
              onPressed: () {
                onItemTapped(2);
              },
              icon: selectedIndex == 2
                  ? Image.asset('assets/icons/HeartBold.png', width: 24.0, height: 24.0)
                  : Image.asset('assets/icons/HeartOut.png', width: 24.0, height: 24.0),
            ),
            IconButton(
              onPressed: () {
                onItemTapped(3);
              },
              icon: selectedIndex == 3
                  ? Image.asset('assets/icons/ProfileBold.png', width: 24.0, height: 24.0)
                  : Image.asset('assets/icons/ProfileOut.png', width: 24.0, height: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
//   final FloatingActionButtonLocation baseLocation;
//   final double offsetY;

//   CustomFloatingActionButtonLocation(this.baseLocation, {this.offsetY = 0.0});

//   @override
//   Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
//     final Offset baseOffset = baseLocation.getOffset(scaffoldGeometry);
//     return Offset(baseOffset.dx, baseOffset.dy + offsetY);
//   }
// }
