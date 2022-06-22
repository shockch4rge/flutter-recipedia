import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: Remove
CollectionReference get USERS => FirebaseFirestore.instance.collection("users");
CollectionReference get RECIPES =>
    FirebaseFirestore.instance.collection("recipes");
CollectionReference get RECIPE_COMMENTS =>
    FirebaseFirestore.instance.collection("comments");
CollectionReference get RECIPE_COMMENT_REPLIES =>
    FirebaseFirestore.instance.collection("replies");
