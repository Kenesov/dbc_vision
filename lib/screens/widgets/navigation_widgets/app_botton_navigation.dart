import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Statistic',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.handshake),
          label: 'Client',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Employee',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Setting',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF4304cb),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true, // Show labels for selected item
      showUnselectedLabels: false, // Hide labels for unselected items
    );
  }
}