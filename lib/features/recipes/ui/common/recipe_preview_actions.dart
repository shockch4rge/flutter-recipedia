import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/app_bottom_sheet.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RecipePreviewActions extends StatelessWidget {
  final Recipe recipe;

  const RecipePreviewActions({Key? key, required this.recipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(actions: [
      AppBottomSheetAction(
        onPressed: () async {
          if (recipe.likes.contains(mockMeId)) {
            context
                .read<RecipeRepository>()
                .addLike(recipeId: recipe.id, likerId: mockMeId);
            return;
          }

          context
              .read<RecipeRepository>()
              .removeLike(recipeId: recipe.id, likerId: mockMeId);
        },
        icon: const Icon(FontAwesomeIcons.solidHeart),
        title: recipe.likes.contains(mockMeId) ? "Unlike" : "Like",
      ),
      if (recipe.authorId == mockMeId)
        AppBottomSheetAction(
          onPressed: () {
            context.read<RecipeRepository>().deleteRecipe(recipeId: recipe.id);
          },
          icon: const Icon(FontAwesomeIcons.trash),
          title: "Delete Recipe",
        ),
    ]);
  }
}
