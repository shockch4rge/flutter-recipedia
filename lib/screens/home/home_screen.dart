import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_recipedia/screens/home/personal_profile/personal_profile_screen.dart';
import 'package:flutter_recipedia/screens/home/post_feed_screen.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentScreenIndex = 0;

  final List<Widget> _screens = [
    const PostFeedScreen(),
    const PostFeedScreen(),
    const PostFeedScreen(),
    const PersonalProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(() {
            _currentScreenIndex = index;
          }),
        },
        unselectedItemColor: Colors.black,
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
        currentIndex: _currentScreenIndex,
      ),
      body: _screens[_currentScreenIndex],
    );
  }
}
