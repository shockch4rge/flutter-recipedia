import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_feed/widgets/recipe_content.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';
import 'package:provider/provider.dart';

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
      body: FutureBuilder(
        future: context.read<RecipeRepository>().getFollowedRecipes(mockMeId),
        builder: (context, snap) {
          if (snap.hasError) {
            return const Center(
              child: Text("There was an error. Try again later."),
            );
          }

          if (snap.waiting) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              cacheExtent: 500,
              itemCount: 4,
              itemBuilder: (context, index) {
                return const RecipeContentPlaceholder();
              },
            );
          }

          final recipes = snap.data as List<Recipe>;

          if (recipes.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: const [
                    Text(
                      "Hmm, its a little lonely in here...",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Create a recipe or follow someone to populate your feed!",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            cacheExtent: 500,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return RecipeContent(recipe: recipes[index]);
            },
          );
        },
      ),
    );
  }
}
