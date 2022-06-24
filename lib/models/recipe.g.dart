// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: const RecipeSerializer()
          .fromJson(json['id'] as DocumentReference<Recipe>),
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      authorId: const UserSerializer()
          .fromJson(json['authorId'] as DocumentReference<User>),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      likes: (json['likes'] as List<dynamic>)
          .map((e) =>
              const UserSerializer().fromJson(e as DocumentReference<User>))
          .toList(),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': const RecipeSerializer().toJson(instance.id),
      'authorId': const UserSerializer().toJson(instance.authorId),
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'likes': instance.likes.map(const UserSerializer().toJson).toList(),
      'ingredients': instance.ingredients,
      'steps': instance.steps,
    };

RecipeComment _$RecipeCommentFromJson(Map<String, dynamic> json) =>
    RecipeComment(
      id: const RecipeCommentSerializer()
          .fromJson(json['id'] as DocumentReference<RecipeComment>),
      authorId: const UserSerializer()
          .fromJson(json['authorId'] as DocumentReference<User>),
      recipeId: const RecipeSerializer()
          .fromJson(json['recipeId'] as DocumentReference<Recipe>),
      content: json['content'] as String,
    );

Map<String, dynamic> _$RecipeCommentToJson(RecipeComment instance) =>
    <String, dynamic>{
      'id': const RecipeCommentSerializer().toJson(instance.id),
      'authorId': const UserSerializer().toJson(instance.authorId),
      'recipeId': const RecipeSerializer().toJson(instance.recipeId),
      'content': instance.content,
    };

RecipeCommentReply _$RecipeCommentReplyFromJson(Map<String, dynamic> json) =>
    RecipeCommentReply(
      id: const RecipeCommentReplySerializer()
          .fromJson(json['id'] as DocumentReference<RecipeCommentReply>),
      authorId: const UserSerializer()
          .fromJson(json['authorId'] as DocumentReference<User>),
      commentId: const RecipeCommentSerializer()
          .fromJson(json['commentId'] as DocumentReference<RecipeComment>),
      recipeId: const RecipeSerializer()
          .fromJson(json['recipeId'] as DocumentReference<Recipe>),
      content: json['content'] as String,
    );

Map<String, dynamic> _$RecipeCommentReplyToJson(RecipeCommentReply instance) =>
    <String, dynamic>{
      'id': const RecipeCommentReplySerializer().toJson(instance.id),
      'authorId': const UserSerializer().toJson(instance.authorId),
      'commentId': const RecipeCommentSerializer().toJson(instance.commentId),
      'recipeId': const RecipeSerializer().toJson(instance.recipeId),
      'content': instance.content,
    };
