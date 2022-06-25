import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

class DocumentSerializer
    implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentSerializer();

  @override
  DocumentReference fromJson(DocumentReference docRef) => docRef;

  @override
  DocumentReference toJson(DocumentReference docRef) => docRef;
}

class RecipeSerializer
    implements
        JsonConverter<DocumentReference<Recipe>, DocumentReference<Recipe>> {
  const RecipeSerializer();

  @override
  DocumentReference<Recipe> fromJson(DocumentReference<Recipe> json) => json;

  @override
  DocumentReference<Recipe> toJson(DocumentReference<Recipe> object) => object;
}

class RecipeCommentSerializer
    implements
        JsonConverter<DocumentReference<RecipeComment>,
            DocumentReference<RecipeComment>> {
  const RecipeCommentSerializer();

  @override
  DocumentReference<RecipeComment> fromJson(
          DocumentReference<RecipeComment> json) =>
      json;

  @override
  DocumentReference<RecipeComment> toJson(
          DocumentReference<RecipeComment> object) =>
      object;
}

class RecipeCommentReplySerializer
    implements
        JsonConverter<DocumentReference<RecipeCommentReply>,
            DocumentReference<RecipeCommentReply>> {
  const RecipeCommentReplySerializer();

  @override
  DocumentReference<RecipeCommentReply> fromJson(
          DocumentReference<RecipeCommentReply> json) =>
      json;

  @override
  DocumentReference<RecipeCommentReply> toJson(
          DocumentReference<RecipeCommentReply> object) =>
      object;
}

class UserSerializer
    implements JsonConverter<DocumentReference<User>, DocumentReference<User>> {
  const UserSerializer();

  @override
  DocumentReference<User> fromJson(DocumentReference<User> json) => json;

  @override
  DocumentReference<User> toJson(DocumentReference<User> object) => object;
}
