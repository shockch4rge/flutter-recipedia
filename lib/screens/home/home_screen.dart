import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_recipedia/screens/app_settings_screen.dart';
import 'package:flutter_recipedia/screens/home/personal_profile/personal_profile_screen.dart';
import 'package:flutter_recipedia/screens/home/post_feed_screen.dart';
import 'package:flutter_recipedia/screens/home/search_screen.dart';

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
    const SearchScreen(),
    const PostFeedScreen(),
    const PersonalProfileScreen(),
    const AppSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _currentScreenIndex = index),
        unselectedItemColor: Colors.black,
        selectedItemColor: Theme.of(context).primaryColorDark,
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
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _currentScreenIndex,
      ),
      body: _screens[_currentScreenIndex],
    );
  }
}
