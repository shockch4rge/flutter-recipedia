import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';

User getMockUser() => const User(
      id: "d12ifdh2itjwid219jsf07a",
      name: "Lisa Hannigan",
      username: "lisahannigan",
    );

Recipe getMockRecipe() => Recipe(
      title: "Neapolitan Pizza",
      description:
          "I was planning to make a beef stew for tonight, but I got lazy midway and decided to whip up this quick carbonara instead! Quick and easy recipe (with no dumb cream)!",
      imageUrl: "assets/images/post_placeholder.jpg",
      ingredients: [
        const RecipeIngredient(
          content: "teaspoons olive oil",
          amount: 2,
          measurement: Measurement.kg,
        )
      ],
      author: getMockUser(),
    );
