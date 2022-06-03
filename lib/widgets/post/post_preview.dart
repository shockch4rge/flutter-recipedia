import 'package:flutter/material.dart';
import 'package:flutter_recipedia/screens/view_recipe_screen.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';

import '../../models/recipe.dart';

class PostPreview extends StatefulWidget {
  final Recipe recipe;

  const PostPreview({Key? key, required this.recipe}) : super(key: key);

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
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
