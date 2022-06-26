import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/recipes/ui/create_recipe/widgets/create_recipe_app_bar.dart';
import 'package:flutter_recipedia/features/recipes/ui/create_recipe/widgets/create_recipe_form.dart';

class CreateRecipeScreen extends StatelessWidget {
  static const routeName = "/create-recipe";

  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateRecipeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: CreateRecipeForm(),
      ),
    );
  }
}
