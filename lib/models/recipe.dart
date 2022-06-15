import 'package:flutter_recipedia/models/user.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final User author;
  final List<RecipeLike> likes;
  final List<RecipeComment> comments;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.ingredients,
    required this.steps,
    required this.likes,
    required this.comments,
  });
}

class RecipeLike {
  final String userId;

  const RecipeLike({
    required this.userId,
  });
}

class RecipeComment {
  final String content;
  final String userId;

  const RecipeComment({
    required this.content,
    required this.userId,
  });
}
