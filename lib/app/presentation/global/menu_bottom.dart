import 'package:flutter/material.dart';

import '../routes/routes.dart';

class MenuBottom extends StatefulWidget {
  final int currentIndex;

  const MenuBottom({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<MenuBottom> createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xff6200ee),
      unselectedItemColor: Colors.grey,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      currentIndex: widget.currentIndex,
      onTap: (value) {
        if (widget.currentIndex != value) {
          if (value == 0) {
            Navigator.popAndPushNamed(context, Routes.home);
          } else if (value == 1) {
            Navigator.popAndPushNamed(context, Routes.perfil);
          }
        }
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Clima',
          icon: Icon(Icons.sunny),
        ),
        BottomNavigationBarItem(
          label: 'Perfil',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
