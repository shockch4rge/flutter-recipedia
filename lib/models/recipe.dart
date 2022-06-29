import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/utils/document_serializer.dart';
import 'package:flutter_recipedia/utils/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

/// we use this annotation to tell json_serializable to map our model to/from JSON.
@JsonSerializable(explicitToJson: true)

/// we use our DocumentSerializer annotation to map DocumentReferences as well,
/// as the default JsonConverter only maps to/from strings.
@DocumentSerializer()
class Recipe {
  // instead of strings, I've stored ids as DocumentReferences to make them easier
  // to query and type. this also allows for some encapsulation of logic.
  final DocumentReference id;
  final DocumentReference authorId;
  final String title;
  final String description;
  final String imageUrl;
  final List<DocumentReference> likes;
  final List<String> ingredients;
  final List<String> steps;
  final String notes;

  /// these static fields are used when querying data, where we don't want to
  /// retype the field name every time and potentially make mistakes.
  static const collectionName = "recipes";
  static const authorIdField = "authorId";
  static const titleField = "title";
  static const descriptionField = "description";
  static const imageUrlField = "imageUrl";
  static const likesField = "likes";
  static const ingredientsField = "ingredients";
  static const stepsField = "steps";
  static const notesField = "notes";

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.authorId,
    required this.ingredients,
    required this.steps,
    required this.likes,
    required this.notes,
  });

  // convenience constructor for the fromFirestore property in CollectionReference.withConverter
  factory Recipe.fromFirestore(DocumentSnapshot snap, dynamic _) {
    final json = snap.data() as JsonResponse;
    // add a property named 'id' to the json
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
  final List<DocumentReference> likes;
  final String content;

  static const collectionName = "comments";
  static const authorIdField = "authorId";
  static const recipeIdField = "recipeId";
  static const contentField = "content";
  static const likesField = "likes";

  const RecipeComment({
    required this.id,
    required this.authorId,
    required this.recipeId,
    required this.content,
    required this.likes,
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
  final List<DocumentReference> likes;
  final String content;

  static const collectionName = "replies";
  static const authorIdField = "authorId";
  static const commentIdField = "commentId";
  static const recipeIdField = "recipeIdField";
  static const contentField = "content";
  static const likesField = "likes";

  const RecipeCommentReply({
    required this.id,
    required this.authorId,
    required this.commentId,
    required this.recipeId,
    required this.likes,
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
