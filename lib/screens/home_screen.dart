import 'package:flutter/material.dart';

import '../main.dart';
import '../models/recipe.dart';
import '../widgets/common/bottom_navbar.dart';
import '../widgets/post/post_content.dart';

class HomeScreen extends StatefulWidget {
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
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return const PostContent(
            recipe: Recipe(
                title: "Grilled Cheese Sandwiches",
                description: "American goodness!"),
          );
        },
      ),
    );
  }
}
