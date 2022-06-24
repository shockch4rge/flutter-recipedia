import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';

class RecipeRepository {
  final CollectionReference<Recipe> _recipes;

  const RecipeRepository(this._recipes);

  Future<List<Recipe>> getUserRecipes(DocumentReference userId) async {
    final snap =
        await _recipes.where(Recipe.authorIdField, isEqualTo: userId).get();

    final recipes = snap.docs.map((doc) => doc.data()).toList();
    return recipes;
  }

  Future<List<Recipe>> getFollowedRecipes(DocumentReference userId) async {
    final user = await userId.get();
    final authorIds =
        await user.get(User.followingField) as List<DocumentReference<User>>;

    final List<Recipe> recipes = [];

    for (final authorId in authorIds) {
      final snap = await _recipes
          .where(
            Recipe.authorIdField,
            isEqualTo: authorId,
          )
          .get();
      recipes.addAll(snap.docs.map((doc) => doc.data()));
    }

    return recipes;
  }
}
