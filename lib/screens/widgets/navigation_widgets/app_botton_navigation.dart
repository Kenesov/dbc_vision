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
          label: 'Statestika',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Klient va Ishilar Info',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Konversiya',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: 'Nostroyka',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF4304cb),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
    );
  }
}