import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/recipe.dart';

class RecipeCommentRepository {
  final CollectionReference _comments;

  const RecipeCommentRepository(this._comments);

  Future<RecipeComment> getById(DocumentReference commentId) async {
    final snap = await commentId
        .withConverter(
          fromFirestore: RecipeComment.fromFirestore,
          toFirestore: RecipeComment.toFirestore,
        )
        .get();
    return snap.data()!;
  }

  Future<List<RecipeComment>> getAllByRecipeId(
    DocumentReference recipeId,
  ) async {
    final snap = await _comments
        .withConverter<RecipeComment>(
          fromFirestore: RecipeComment.fromFirestore,
          toFirestore: RecipeComment.toFirestore,
        )
        .where(RecipeComment.recipeIdField, isEqualTo: recipeId)
        .get();

    return snap.docs.map((doc) => doc.data()).toList();
  }
}
