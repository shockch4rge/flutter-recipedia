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
        .where(
          Recipe.authorIdField,
          isEqualTo: userId,
        )
        .withConverter(
          fromFirestore: Recipe.fromFirestore,
          toFirestore: Recipe.toFirestore,
        )
        .get();

    final recipes = snap.docs.map((doc) => doc.data()).toList();
    return recipes;
  }

  Future<List<DocumentReference>> getFollowedRecipeIds(
    DocumentReference userId,
  ) async {
    final user = await userId
        .withConverter<User>(
          fromFirestore: User.fromFirestore,
          toFirestore: User.toFirestore,
        )
        .get();

    final authorIds = user.get(User.followingField) as List<dynamic>;
    final List<DocumentReference> recipeIds = [];

    for (final authorId in authorIds) {
      final snap = await _recipes
          .withConverter<Recipe>(
              fromFirestore: Recipe.fromFirestore,
              toFirestore: Recipe.toFirestore)
          .where(Recipe.authorIdField, whereIn: [authorId, userId]).get();

      recipeIds.addAll(snap.docs.map((doc) => doc.reference).toList());
    }
    return recipeIds;
  }

  Stream<Recipe> getRecipeUpdates(DocumentReference recipeId) {
    return recipeId
        .withConverter<Recipe>(
            fromFirestore: Recipe.fromFirestore,
            toFirestore: Recipe.toFirestore)
        .snapshots()
        .map((snap) => snap.data()!);
  }

  // is not implemented yet
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

  Future<void> addRecipe({
    required DocumentReference authorId,
    required String title,
    required String description,
    required List<String> ingredients,
    required List<String> steps,
    required File image,
    required String notes,
  }) async {
    final recipeId = _recipes.doc();
    final imageUrl = await _images.uploadImage(recipeId: recipeId, file: image);

    await recipeId.set({
      Recipe.authorIdField: authorId,
      Recipe.titleField: title,
      Recipe.descriptionField: description,
      Recipe.ingredientsField: ingredients,
      Recipe.stepsField: steps,
      Recipe.imageUrlField: imageUrl,
      Recipe.likesField: [],
      Recipe.notesField: notes,
    });
  }

  Future<void> deleteRecipe({required DocumentReference recipeId}) async {
    await recipeId.delete();
  }

  Future<void> addLike({
    required DocumentReference recipeId,
    required DocumentReference likerId,
  }) async {
    await recipeId.update({
      Recipe.likesField: FieldValue.arrayUnion([likerId]),
    });
  }

  Future<void> removeLike({
    required DocumentReference recipeId,
    required DocumentReference likerId,
  }) async {
    await recipeId.update({
      Recipe.likesField: FieldValue.arrayRemove([likerId]),
    });
  }

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

  Future<List<Recipe>> getRecipes({
    required List<DocumentReference> recipeIds,
  }) async {
    final snaps = await Future.wait(
      recipeIds.map((recipeId) {
        return recipeId
            .withConverter<Recipe>(
              fromFirestore: Recipe.fromFirestore,
              toFirestore: Recipe.toFirestore,
            )
            .get();
      }),
    );

    return snaps.map((snap) => snap.data()!).toList();
  }
}
