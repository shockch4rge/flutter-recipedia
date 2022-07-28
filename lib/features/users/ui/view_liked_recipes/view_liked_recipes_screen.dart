import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/users/ui/view_liked_recipes/widgets/view_liked_recipes_app_bar.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:provider/provider.dart';

class ViewLikedRecipesScreen extends StatefulWidget {
  static const routeName = "/home/profile/me/liked";

  const ViewLikedRecipesScreen({Key? key}) : super(key: key);

  @override
  State<ViewLikedRecipesScreen> createState() => _ViewLikedRecipesScreenState();
}

class _ViewLikedRecipesScreenState extends State<ViewLikedRecipesScreen> {
  late final userId = context.read<AuthProvider>().user!.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ViewLikedRecipesAppBar(),
      body: FutureBuilder(
        future:
            context.read<RecipeRepository>().getLikedRecipes(userId: userId),
        builder: (context, snap) {
          if (snap.waiting) {
            return Container();
          }

          final likedRecipes = snap.data as List<Recipe>;

          if (likedRecipes.isEmpty) {
            return const Center(
              child: Text("You haven't liked any recipes yet."),
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
              itemCount: likedRecipes.length,
              itemBuilder: (_, index) {
                return CachedNetworkImage(
                  imageUrl: likedRecipes[index].imageUrl,
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
