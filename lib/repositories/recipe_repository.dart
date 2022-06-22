import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/recipe.dart';

class RecipeRepository {
  final CollectionReference _recipes;

  const RecipeRepository(this._recipes);

  Future<List<Recipe>> getUserRecipes(DocumentReference userId) async {
    final snap = await _recipes
        .withConverter<Recipe>(
          fromFirestore: Recipe.fromFirestore,
          toFirestore: Recipe.toFirestore,
        )
        .where(Recipe.authorIdField, isEqualTo: userId)
        .get();

    final recipes = snap.docs.map((doc) => doc.data()).toList();
    return recipes;
  }
}
