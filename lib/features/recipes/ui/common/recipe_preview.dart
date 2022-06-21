import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/recipe.dart';
import '../view_recipe/view_recipe_screen.dart';

class RecipePreview extends StatelessWidget {
  final Recipe recipe;

  const RecipePreview({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        ViewRecipeScreen.routeName,
        arguments: recipe,
      ),
      child: CachedNetworkImage(
        imageUrl: recipe.imageUrl,
        imageBuilder: (context, provider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: provider, fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(6),
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
