import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';

User getMockUser() => const User(
      id: "d12ifdh2itjwid219jsf07a",
      name: "Lisa Hannigan",
      username: "lisahannigan",
      avatarUrl: "assets/images/avatar_placeholder.png",
    );

Recipe getMockRecipe() => Recipe(
      title: "Truffle Spaghetti",
      description:
          "I was planning to make a beef stew for tonight, but I got lazy midway and decided to whip up this quick carbonara instead! Quick and easy recipe (with no dumb cream)!",
      imageUrl: "assets/images/post_placeholder.jpg",
      ingredients: [
        "2 teaspoons olive oil",
        "1 pound guanciale (cured pork cheek), diced",
        "1 (16 ounce) package spaghetti",
        "3 eggs",
        "10 tablespoons grated Pecorino Romano cheese, divided",
        "salt and ground black pepper to taste"
      ],
      steps: [
        "Heat olive oil in a large skillet over medium heat; add guanciale (see Cook's Note). Cook, turning occasionally, until evenly browned and crispy, 5 to 10 minutes. Remove from heat and drain on paper towels. ",
        "Bring a large pot of salted water to a boil. Cook spaghetti in the boiling water, stirring occasionally until tender yet firm to the bite, about 9 minutes. Drain and return to the pot. Let cool, stirring occasionally, about 5 minutes.",
        "Whisk eggs, half of the Pecorino Romano cheese, and some black pepper in a bowl until smooth and creamy.\nPour egg mixture over pasta, stirring quickly, until creamy and slightly cooled. Stir in guanciale. Top with remaining Pecorino Romano cheese and more black pepper."
      ],
      author: getMockUser(),
    );
