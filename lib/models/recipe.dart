import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/utils/document_serializer.dart';
import 'package:flutter_recipedia/utils/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class Recipe {
  final DocumentReference id;
  final DocumentReference authorId;
  final String title;
  final String description;
  final String imageUrl;
  final List<DocumentReference> likes;
  final List<String> ingredients;
  final List<String> steps;

  static const collectionName = "recipes";
  static const authorIdField = "authorId";
  static const titleField = "title";
  static const descriptionField = "description";
  static const imageUrlField = "imageUrl";
  static const likesField = "likes";
  static const ingredientsField = "ingredients";
  static const stepsField = "steps";

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.authorId,
    required this.ingredients,
    required this.steps,
    required this.likes,
  });

  factory Recipe.fromFirestore(DocumentSnapshot snap, dynamic _) {
    final json = snap.data() as JsonResponse;
    json["id"] = snap.reference;

    return Recipe.fromJson(json);
  }

  static JsonResponse toFirestore(Recipe recipe, dynamic _) => recipe.toJson();

  factory Recipe.fromJson(JsonResponse json) {
    return _$RecipeFromJson(json);
  }

  JsonResponse toJson() => _$RecipeToJson(this);
}

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class RecipeComment {
  final DocumentReference id;
  final DocumentReference authorId;
  final DocumentReference recipeId;
  final String content;

  static const collectionName = "comments";
  static const authorIdField = "authorId";
  static const recipeIdField = "recipeId";
  static const contentField = "content";

  const RecipeComment({
    required this.id,
    required this.authorId,
    required this.recipeId,
    required this.content,
  });

  factory RecipeComment.fromFirestore(DocumentSnapshot snap, dynamic _) {
    final json = snap.data()! as JsonResponse;
    json["id"] = snap.reference;
    return RecipeComment.fromJson(json);
  }

  static JsonResponse toFirestore(RecipeComment comment, dynamic _) =>
      comment.toJson();

  factory RecipeComment.fromJson(JsonResponse json) =>
      _$RecipeCommentFromJson(json);

  JsonResponse toJson() => _$RecipeCommentToJson(this);
}

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class RecipeCommentReply {
  final DocumentReference id;
  final DocumentReference authorId;
  final DocumentReference commentId;
  final DocumentReference recipeId;
  final String content;

  static const collectionName = "replies";
  static const authorIdField = "authorId";
  static const commentIdField = "commentId";
  static const recipeIdField = "recipeIdField";
  static const contentField = "content";

  const RecipeCommentReply({
    required this.id,
    required this.authorId,
    required this.commentId,
    required this.recipeId,
    required this.content,
  });

  factory RecipeCommentReply.fromFirestore(DocumentSnapshot snap, dynamic _) {
    final json = snap.data()! as JsonResponse;
    json["id"] = snap.reference;
    return RecipeCommentReply.fromJson(json);
  }

  factory RecipeCommentReply.fromJson(JsonResponse json) =>
      _$RecipeCommentReplyFromJson(json);

  static JsonResponse toFirestore(RecipeCommentReply reply, dynamic _) =>
      reply.toJson();

  JsonResponse toJson() => _$RecipeCommentReplyToJson(this);
}
