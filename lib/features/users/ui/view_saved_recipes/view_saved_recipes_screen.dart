import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/users/ui/view_saved_recipes/widgets/view_saved_recipes_app_bar.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:provider/provider.dart';

class ViewSavedRecipesScreen extends StatefulWidget {
  static const routeName = "/home/profile/me/saved";

  const ViewSavedRecipesScreen({Key? key}) : super(key: key);

  @override
  State<ViewSavedRecipesScreen> createState() => _ViewSavedRecipesScreenState();
}

class _ViewSavedRecipesScreenState extends State<ViewSavedRecipesScreen> {
  late final user = context.read<AuthProvider>().user!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ViewSavedRecipesAppBar(),
      body: FutureBuilder(
        future: context
            .read<RecipeRepository>()
            .getRecipes(recipeIds: user.savedRecipes),
        builder: (context, snap) {
          if (snap.waiting) {
            return Container();
          }

          final savedRecipes = snap.data as List<Recipe>;

          if (savedRecipes.isEmpty) {
            return const Center(
              child: Text("You haven't saved any recipes yet."),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: savedRecipes.length,
              itemBuilder: (_, index) {
                return CachedNetworkImage(
                  imageUrl: savedRecipes[index].imageUrl,
                  imageBuilder: (_, image) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
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
