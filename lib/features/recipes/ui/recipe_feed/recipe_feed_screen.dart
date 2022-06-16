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
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeFeedAppBar(
        onTitleTapped: () => _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
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
