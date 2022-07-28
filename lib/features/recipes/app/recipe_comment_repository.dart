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

  Stream<int> getCommentCountByRecipeId(DocumentReference recipeId) {
    return _comments
        .withConverter<RecipeComment>(
          fromFirestore: RecipeComment.fromFirestore,
          toFirestore: RecipeComment.toFirestore,
        )
        .where(RecipeComment.recipeIdField, isEqualTo: recipeId)
        .snapshots()
        .map((snap) => snap.docs.length);
  }

  Stream<List<RecipeComment>> getAllByRecipeIdStream(
      DocumentReference recipeId) {
    return _comments
        .withConverter<RecipeComment>(
          fromFirestore: RecipeComment.fromFirestore,
          toFirestore: RecipeComment.toFirestore,
        )
        .where('recipeId', isEqualTo: recipeId)
        // .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
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

  Future<void> addComment({
    required DocumentReference recipeId,
    required DocumentReference authorId,
    required String content,
  }) async {
    final comment = _comments.doc();

    await comment.set({
      RecipeComment.authorIdField: authorId,
      RecipeComment.recipeIdField: recipeId,
      RecipeComment.contentField: content,
      RecipeComment.likesField: [],
    });
  }

  Future<void> deleteComment(DocumentReference commentId) async {
    await commentId.delete();
  }

  Future<void> addLike({
    required DocumentReference commentId,
    required DocumentReference likerId,
  }) async {
    commentId.update({
      RecipeComment.likesField: FieldValue.arrayUnion([likerId]),
    });
  }

  Future<void> removeLike({
    required DocumentReference commentId,
    required DocumentReference likerId,
  }) async {
    commentId.update({
      RecipeComment.likesField: FieldValue.arrayRemove([likerId]),
    });
  }
}
