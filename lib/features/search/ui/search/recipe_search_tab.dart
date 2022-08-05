import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/search/app/search_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/recipe_search_result.dart';

class RecipeSearchTab extends StatefulWidget {
  const RecipeSearchTab({Key? key}) : super(key: key);

  @override
  State<RecipeSearchTab> createState() => _RecipeSearchTabState();
}

class _RecipeSearchTabState extends State<RecipeSearchTab> {
  @override
  Widget build(BuildContext context) {
    final isSearching = context.watch<SearchProvider>().isSearchingRecipes;
    final recipes = context.watch<SearchProvider>().recipes;

    if (isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (recipes.isEmpty) {
      return const Center(
        child: Text("There are no recipes to display!"),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return RecipeSearchResult(recipe: recipes[index]);
      },
      itemCount: recipes.length,
    );
  }
}
