import 'package:flutter/material.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';

import '../main.dart';
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
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        centerTitle: true,
        title:
            const Text("recipedia", style: TextStyle(color: App.primaryColor)),
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
