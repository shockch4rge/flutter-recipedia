import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';

// TODO: Remove
CollectionReference<User> get USERS =>
    FirebaseFirestore.instance.collection("users").withConverter<User>(
          fromFirestore: User.fromFirestore,
          toFirestore: User.toFirestore,
        );
CollectionReference<Recipe> get RECIPES =>
    FirebaseFirestore.instance.collection("recipes").withConverter<Recipe>(
          fromFirestore: Recipe.fromFirestore,
          toFirestore: Recipe.toFirestore,
        );
CollectionReference<RecipeComment> get RECIPE_COMMENTS =>
    FirebaseFirestore.instance
        .collection("comments")
        .withConverter<RecipeComment>(
          fromFirestore: RecipeComment.fromFirestore,
          toFirestore: RecipeComment.toFirestore,
        );
CollectionReference<RecipeCommentReply> get RECIPE_COMMENT_REPLIES =>
    FirebaseFirestore.instance
        .collection("replies")
        .withConverter<RecipeCommentReply>(
          fromFirestore: RecipeCommentReply.fromFirestore,
          toFirestore: RecipeCommentReply.toFirestore,
        );
