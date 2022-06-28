import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/recipe.dart';

class RecipeCommentReplyRepository {
  final CollectionReference _replies;

  const RecipeCommentReplyRepository(this._replies);

  Future<List<RecipeCommentReply>> getAllByCommentId(
    DocumentReference commentId,
  ) async {
    final snap = await _replies
        .withConverter<RecipeCommentReply>(
          fromFirestore: RecipeCommentReply.fromFirestore,
          toFirestore: RecipeCommentReply.toFirestore,
        )
        .where(RecipeCommentReply.commentIdField, isEqualTo: commentId)
        .get();

    final replies = snap.docs.map((doc) => doc.data()).toList();
    return replies;
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

  Future<void> addToComment(
    DocumentReference commentId,
    RecipeCommentReply reply,
  ) async {
    final replyId = _replies.doc().withConverter<RecipeCommentReply>(
          fromFirestore: RecipeCommentReply.fromFirestore,
          toFirestore: RecipeCommentReply.toFirestore,
        );
    replyId.set(reply);
  }

  Future<void> addReply({
    required recipeId,
    required commentId,
    required authorId,
    required content,
  }) async {
    final reply = _replies.doc();
    await reply.set({
      RecipeCommentReply.authorIdField: authorId,
      RecipeCommentReply.recipeIdField: recipeId,
      RecipeCommentReply.contentField: content,
      RecipeCommentReply.likesField: [],
    });
  }

  Future<void> addLike({
    required DocumentReference replyId,
    required DocumentReference likerId,
  }) async {
    replyId.update({
      RecipeCommentReply.likesField: FieldValue.arrayUnion([likerId]),
    });
  }

  Future<void> removeLike({
    required DocumentReference replyId,
    required DocumentReference likerId,
  }) async {
    replyId.update({
      RecipeCommentReply.likesField: FieldValue.arrayRemove([likerId]),
    });
  }
}
