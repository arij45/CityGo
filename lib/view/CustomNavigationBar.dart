import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  CustomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Color(0xFF3C77E1),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 10,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
              'assets/images/setting.png',
            width: 30,
            height: 30,
          ),
          label: 'Requests',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/requesta.png',
            width: 30,
            height: 30,
          ),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/accept.png',
            width: 30,
            height: 30),
          label: 'Settings',
        ),
      ],
    );
  }
}

