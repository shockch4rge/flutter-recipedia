// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: const DocumentSerializer()
          .fromJson(json['id'] as DocumentReference<Object?>),
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      authorId: const DocumentSerializer()
          .fromJson(json['authorId'] as DocumentReference<Object?>),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      likes: (json['likes'] as List<dynamic>)
          .map((e) => const DocumentSerializer()
              .fromJson(e as DocumentReference<Object?>))
          .toList(),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': const DocumentSerializer().toJson(instance.id),
      'authorId': const DocumentSerializer().toJson(instance.authorId),
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'likes': instance.likes.map(const DocumentSerializer().toJson).toList(),
      'ingredients': instance.ingredients,
      'steps': instance.steps,
    };

RecipeComment _$RecipeCommentFromJson(Map<String, dynamic> json) =>
    RecipeComment(
      id: const DocumentSerializer()
          .fromJson(json['id'] as DocumentReference<Object?>),
      authorId: const DocumentSerializer()
          .fromJson(json['authorId'] as DocumentReference<Object?>),
      recipeId: const DocumentSerializer()
          .fromJson(json['recipeId'] as DocumentReference<Object?>),
      content: json['content'] as String,
    );

Map<String, dynamic> _$RecipeCommentToJson(RecipeComment instance) =>
    <String, dynamic>{
      'id': const DocumentSerializer().toJson(instance.id),
      'authorId': const DocumentSerializer().toJson(instance.authorId),
      'recipeId': const DocumentSerializer().toJson(instance.recipeId),
      'content': instance.content,
    };

RecipeCommentReply _$RecipeCommentReplyFromJson(Map<String, dynamic> json) =>
    RecipeCommentReply(
      id: const DocumentSerializer()
          .fromJson(json['id'] as DocumentReference<Object?>),
      authorId: const DocumentSerializer()
          .fromJson(json['authorId'] as DocumentReference<Object?>),
      commentId: const DocumentSerializer()
          .fromJson(json['commentId'] as DocumentReference<Object?>),
      recipeId: const DocumentSerializer()
          .fromJson(json['recipeId'] as DocumentReference<Object?>),
      content: json['content'] as String,
    );

Map<String, dynamic> _$RecipeCommentReplyToJson(RecipeCommentReply instance) =>
    <String, dynamic>{
      'id': const DocumentSerializer().toJson(instance.id),
      'authorId': const DocumentSerializer().toJson(instance.authorId),
      'commentId': const DocumentSerializer().toJson(instance.commentId),
      'recipeId': const DocumentSerializer().toJson(instance.recipeId),
      'content': instance.content,
    };
