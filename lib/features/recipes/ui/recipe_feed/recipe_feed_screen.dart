import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/keep_alive_stateful.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_feed/widgets/recipe_content.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';
import 'package:provider/provider.dart';

import 'widgets/recipe_feed_app_bar.dart';

class RecipeFeedScreen extends KeepAliveStateful {
  static const routeName = "/home/feed";

  const RecipeFeedScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeFeedScreenState();
}

class _RecipeFeedScreenState extends KeepAliveState {
  final _scrollController = ScrollController();
  late final getFollowedRecipeIds =
      context.read<RecipeRepository>().getFollowedRecipeIds;
  late final getRecipeUpdates =
      context.read<RecipeRepository>().getRecipeUpdates;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: RecipeFeedAppBar(
        onTitleTapped: () => _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ),
      body: FutureBuilder(
        future: getFollowedRecipeIds(mockMeId),
        builder: (context, snap) {
          if (snap.hasError) {
            return const Center(
              child: Text("There was an error. Try again later."),
            );
          }

          if (snap.waiting) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const RecipeContentPlaceholder();
              },
            );
          }

          final recipeIds = snap.data as List<DocumentReference>;

          if (recipeIds.isEmpty) {
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

          return RefreshIndicator(
            strokeWidth: 3.0,
            color: Theme.of(context).primaryColor,
            displacement: 20,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              await getFollowedRecipeIds(mockMeId);
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: recipeIds.length,
              cacheExtent: 400.0 * recipeIds.length,
              itemBuilder: (context, index) {
                return StreamBuilder(
                  stream: getRecipeUpdates(recipeIds[index]),
                  builder: (_, snap) {
                    if (snap.waiting) {
                      return const RecipeContentPlaceholder();
                    }
                    final recipe = snap.data as Recipe;
                    return RecipeContent(recipe: recipe);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
