import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';
import 'package:flutter_recipedia/widgets/common/appbar.dart';

import '../widgets/common/bottom_navbar.dart';
import '../widgets/post/post_content.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(),
      appBar: const Appbar(
        title: Text(
          "recipedia",
          style: TextStyle(color: App.primaryColor),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        cacheExtent: 500,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return PostContent(
            recipe: getMockRecipe(),
          );
        },
      ),
    );
  }
}
