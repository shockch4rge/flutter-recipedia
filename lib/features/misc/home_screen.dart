import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_recipedia/features/recipes/ui/create_recipe/create_recipe_screen.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_feed/recipe_feed_screen.dart';
import 'package:flutter_recipedia/features/search/ui/search_screen.dart';
import 'package:flutter_recipedia/features/settings/ui/app_settings_screen.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile/personal_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final pageController = PageController();

  final List<Widget> _screens = [
    const RecipeFeedScreen(),
    const SearchScreen(),
    const CreateRecipeScreen(),
    const PersonalProfileScreen(),
    const AppSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              pageController.animateToPage(
                index,
                curve: Curves.easeInOutCubicEmphasized,
                duration: Duration(milliseconds: 200),
              );
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Theme.of(context).primaryColorDark,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.home),
              label: "•",
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.search),
              label: "•",
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.plusSquare),
              label: "•",
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.user),
              label: "•",
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.settings),
              label: "•",
            ),
          ],
          currentIndex: _currentIndex,
        ),
        body: PageView(
          controller: pageController,
          scrollBehavior: null,
          children: _screens,
        ));
  }
}
