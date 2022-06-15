import 'package:flutter/material.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';

import 'widgets/recipe_content.dart';
import 'widgets/recipe_feed_app_bar.dart';

class RecipeFeedScreen extends StatefulWidget {
  static const routeName = "/home/feed";

  const RecipeFeedScreen({Key? key}) : super(key: key);

  @override
  State<RecipeFeedScreen> createState() => _RecipeFeedScreenState();
}

class _RecipeFeedScreenState extends State<RecipeFeedScreen> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeFeedAppBar(controller: _controller),
      body: ListView.builder(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        cacheExtent: 500,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return RecipeContent(recipe: mockRecipe);
        },
      ),
    );
  }
}
