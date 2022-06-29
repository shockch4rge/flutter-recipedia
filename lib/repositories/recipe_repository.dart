import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';

import '../features/recipes/app/recipe_image_repository.dart';

class RecipeRepository {
  final CollectionReference _recipes;
  final RecipeImageRepository _images;
  Query<Recipe>? batchQuery;
  DocumentSnapshot<Recipe>? lastFetched;

  RecipeRepository(this._recipes, this._images);

  Future<List<Recipe>> getUserRecipes(DocumentReference userId) async {
    final snap = await _recipes
        // filter the documents by their authorId and match with the param
        .where(
          Recipe.authorIdField,
          isEqualTo: userId,
        )
        // this converter method is commonly seen to type our return data from
        // raw json to our model.
        .withConverter(
          fromFirestore: Recipe.fromFirestore,
          toFirestore: Recipe.toFirestore,
        )
        .get();

    final recipes = snap.docs.map((doc) => doc.data()).toList();
    return recipes;
  }

  // get a user's followed recipes; including their own
  Future<List<Recipe>> getFollowedRecipes(DocumentReference userId) async {
    final user = await userId
        .withConverter<User>(
          fromFirestore: User.fromFirestore,
          toFirestore: User.toFirestore,
        )
        .get();

    // get all authorIds in the user's following list
    final authorIds = user.get(User.followingField);
    final List<Recipe> followedRecipes = [];

    for (final authorId in authorIds) {
      // map over each authorId and fetch all their recipes
      final snap = await _recipes
          .withConverter<Recipe>(
              fromFirestore: Recipe.fromFirestore,
              toFirestore: Recipe.toFirestore)
          // include the user's own recipes as well
          .where(Recipe.authorIdField, whereIn: [authorId, userId]).get();

      // map each element to a recipe
      // the generic arg provided in withConverter is supplied to doc.data(), hence we receive the correct type
      final userRecipes = snap.docs.map((doc) => doc.data());
      // concatenate the user's recipes with the total recipes
      followedRecipes.addAll(userRecipes);
    }

    return followedRecipes;
  }

  /// this is not implemented in the app yet
  Stream<List<Recipe>> getBatchedFollowedRecipes(
    DocumentReference userId,
  ) async* {
    // get the current user and their followers
    final user = await userId.get();
    final authorIds = user.get(User.followingField) as List<DocumentReference>;

    // map over each follower
    for (final authorId in authorIds) {
      // check if we've made a previous query before
      // and if it returned the last doc
      if (batchQuery != null && lastFetched != null) {
        // reassign the query to start after the last fetched doc
        batchQuery = batchQuery!.startAfterDocument(lastFetched!).limit(1);
      }

      // if we've not made a query before, create one where we only fetch the
      // first few results
      batchQuery ??= _recipes
          .withConverter<Recipe>(
            fromFirestore: Recipe.fromFirestore,
            toFirestore: Recipe.toFirestore,
          )
          .where(Recipe.authorIdField, isEqualTo: authorId)
          // TODO: test with 1 first
          .limit(1);

      final currentBatch = await batchQuery!.get();

      // save the last doc in the batch
      lastFetched = currentBatch.docs.last;
      yield currentBatch.docs.map((doc) => doc.data()).toList();
    }
  }

  // add a recipe to the db
  Future<void> addRecipe({
    required DocumentReference authorId,
    required String title,
    required String description,
    required List<String> ingredients,
    required List<String> steps,
    required File image,
  }) async {
    // create a reference
    final recipeId = _recipes.doc();
    // upload the image to firebase storage first, and then get the url
    final imageUrl = await _images.uploadImage(recipeId: recipeId, file: image);

    // finally, set the recipe data
    await recipeId.set({
      Recipe.authorIdField: authorId,
      Recipe.titleField: title,
      Recipe.descriptionField: description,
      Recipe.ingredientsField: ingredients,
      Recipe.stepsField: steps,
      Recipe.imageUrlField: imageUrl,
      Recipe.likesField: [],
    });
  }

  Future<void> deleteRecipe({required DocumentReference recipeId}) async {
    await recipeId.delete();
  }

  // like a recipe
  Future<void> addLike({
    required DocumentReference recipeId,
    required DocumentReference likerId,
  }) async {
    await recipeId.update({
      Recipe.likesField: FieldValue.arrayUnion([likerId]),
    });
  }

  // remove a recipe like from the likes field of the recipe
  Future<void> removeLike({
    required DocumentReference recipeId,
    required DocumentReference likerId,
  }) async {
    await recipeId.update({
      Recipe.likesField: FieldValue.arrayRemove([likerId]),
    });
  }

  // get all of a user's liked recipes
  Future<List<Recipe>> getLikedRecipes({
    required DocumentReference userId,
  }) async {
    final snap = await _recipes
        .withConverter<Recipe>(
          fromFirestore: Recipe.fromFirestore,
          toFirestore: Recipe.toFirestore,
        )
        .where(Recipe.likesField, arrayContains: userId)
        .get();

    return snap.docs.map((doc) => doc.data()).toList();
  }
}
