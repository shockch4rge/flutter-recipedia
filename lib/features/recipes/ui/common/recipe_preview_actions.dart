import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/app_bottom_sheet.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RecipePreviewActions extends StatefulWidget {
  final Recipe recipe;

  const RecipePreviewActions({Key? key, required this.recipe})
      : super(key: key);

  @override
  State<RecipePreviewActions> createState() => _RecipePreviewActionsState();
}

class _RecipePreviewActionsState extends State<RecipePreviewActions> {
  late final currentUser = context.read<AuthProvider>().user!;

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(actions: [
      AppBottomSheetAction(
        onPressed: () async {
          if (widget.recipe.likes.contains(currentUser.id)) {
            context
                .read<RecipeRepository>()
                .addLike(recipeId: widget.recipe.id, likerId: currentUser.id);
            return;
          }

          context
              .read<RecipeRepository>()
              .removeLike(recipeId: widget.recipe.id, likerId: currentUser.id);
        },
        icon: const Icon(FontAwesomeIcons.solidHeart),
        title: widget.recipe.likes.contains(currentUser.id) ? "Unlike" : "Like",
      ),
      if (widget.recipe.authorId == currentUser.id)
        AppBottomSheetAction(
          onPressed: () {
            context
                .read<RecipeRepository>()
                .deleteRecipe(recipeId: widget.recipe.id);
          },
          icon: const Icon(FontAwesomeIcons.trash),
          title: "Delete Recipe",
        ),
    ]);
  }
}
