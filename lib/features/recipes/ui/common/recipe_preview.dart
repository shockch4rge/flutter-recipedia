import 'package:flutter/material.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';

import '../../../../models/recipe.dart';
import '../view_recipe/view_recipe_screen.dart';

class RecipePreview extends StatefulWidget {
  final Recipe recipe;

  const RecipePreview({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipePreview> createState() => _RecipePreviewState();
}

class _RecipePreviewState extends State<RecipePreview> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
      },
      onTap: () {
        Navigator.pushNamed(
          context,
          ViewRecipeScreen.routeName,
          arguments: mockRecipe,
        );
      },
      child: AnimatedPhysicalModel(
        color: Colors.black,
        shadowColor: Colors.black,
        shape: BoxShape.rectangle,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        elevation: isPressed ? 8.0 : 0,
        borderRadius: BorderRadius.circular(6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/post_placeholder.jpg"),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
