import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/recipe.dart';

class RecipeCommentReplyRepository {
  final CollectionReference _replies;

  const RecipeCommentReplyRepository(this._replies);

  Future<List<RecipeCommentReply>> getAllByCommentId(
    DocumentReference commentRef,
  ) async {
    final snap = await _replies
        .withConverter<RecipeCommentReply>(
          fromFirestore: RecipeCommentReply.fromFirestore,
          toFirestore: RecipeCommentReply.toFirestore,
        )
        .where("comment", isEqualTo: commentRef)
        .get();

    return snap.docs.map((doc) => doc.data()).toList();
  }

  Future<RecipeCommentReply> getByCommentId(String commentId) async {
    final snap = await _replies
        .withConverter<RecipeCommentReply>(
          fromFirestore: RecipeCommentReply.fromFirestore,
          toFirestore: RecipeCommentReply.toFirestore,
        )
        .doc(commentId)
        .get();

    return snap.data()!;
  }
}
