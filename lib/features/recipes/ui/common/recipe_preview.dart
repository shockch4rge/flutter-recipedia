import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/app_bottom_sheet.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/recipe_preview_actions.dart';
import 'package:flutter_recipedia/models/user.dart';

import '../../../../models/recipe.dart';
import '../view_recipe/view_recipe_screen.dart';

class RecipePreview extends StatelessWidget {
  final Recipe recipe;
  final User user;

  const RecipePreview({
    Key? key,
    required this.recipe,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        ViewRecipeScreen.routeName,
        arguments: recipe,
      ),
      onLongPress: () => showModalBottomSheet(
        context: context,
        shape: AppBottomSheet.defaultShape,
        builder: (_) => RecipePreviewActions(recipe: recipe),
      ),
      child: CachedNetworkImage(
        imageUrl: recipe.imageUrl,
        imageBuilder: (context, provider) {
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: provider, fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          );
        },
        placeholder: (context, imageUrl) => Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey.shade200,
            color: Colors.grey.shade300,
          ),
        ),
        errorWidget: (context, imageUrl, error) => Container(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
