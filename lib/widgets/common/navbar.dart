import "package:flutter/material.dart";
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_recipedia/main.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => App.screens[index],
        ),
      ),
      unselectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(),
      selectedItemColor: App.primaryAccent,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FeatherIcons.home, size: 26),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(FeatherIcons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(FeatherIcons.plusSquare),
          label: "Create",
        ),
        BottomNavigationBarItem(
          icon: Icon(FeatherIcons.user),
          label: "Profile",
        ),
      ],
    );
  }
}
