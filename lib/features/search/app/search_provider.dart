import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/utils/secrets.dart';
import 'package:http/http.dart' as http;

enum SearchTerm { user, recipe }

class SearchProvider with ChangeNotifier {
  String query = "";
  bool isSearchingRecipes = false;
  bool isSearchingUsers = false;
  SearchTerm searchTerm = SearchTerm.user;
  List<SpoonacularRecipe> recipes = [];
  List<User> users = [];
  final CollectionReference _users;

  SearchProvider(this._users);

  void setSearchTerm(SearchTerm searchTerm) {
    this.searchTerm = searchTerm;
    notifyListeners();
  }

  void setQuery(String query) {
    this.query = query;
    notifyListeners();
  }

  Future<void> searchForUsers(String query) async {
    users.clear();
    isSearchingUsers = true;
    notifyListeners();

    final snap = await _users
        .withConverter<User>(
            fromFirestore: User.fromFirestore, toFirestore: User.toFirestore)
        .where(User.nameField, isGreaterThanOrEqualTo: query)
        .where(User.nameField, isLessThanOrEqualTo: "$query\uf8ff")
        .where(User.usernameField, isGreaterThanOrEqualTo: query)
        .where(User.usernameField, isLessThanOrEqualTo: "$query\uf8ff")
        .limit(20)
        .get();

    users = snap.docs.map((doc) => doc.data()).toList();
    isSearchingUsers = false;
    notifyListeners();
  }

  Future<void> searchForRecipes(String query) async {
    recipes.clear();
    isSearchingRecipes = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse(
        "https://api.spoonacular.com/recipes/complexSearch?query=$query&number=3&addRecipeInformation=true",
      ),
      headers: {
        "x-api-key": spoonacularApiKey,
      },
    );
    recipes = (jsonDecode(response.body)["results"] as List<dynamic>)
        .map((json) => SpoonacularRecipe.fromJson(json))
        .toList();

    isSearchingRecipes = false;
    notifyListeners();
  }
}
