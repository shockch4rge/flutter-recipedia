import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/search/ui/view_searched_recipe/view_searched_recipe_screen.dart';
import 'package:flutter_recipedia/models/recipe.dart';

class RecipeSearchResult extends StatelessWidget {
  final SpoonacularRecipe recipe;

  const RecipeSearchResult({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ViewSearchedRecipeScreen.routeName,
              arguments: recipe,
            );
          },
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: recipe.imageUrl,
                imageBuilder: (context, image) {
                  return Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent],
                      stops: [0, 0.4],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: SizedBox(
                  width: 300,
                  child: Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
