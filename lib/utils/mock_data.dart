import '../models/user.dart';
import 'constants/firestore_collections.dart';

// this is our test user for the application.
// while authentication is not implemented for this submission, the user
// remains in the database for testing purposes.
final mockMeId = USERS
    .withConverter<User>(
      fromFirestore: User.fromFirestore,
      toFirestore: User.toFirestore,
    )
    .doc("sOCPIiDNpxC3qlW7tzEb");

// final mockRecipe = Recipe(
//   id: "2i2ffw8gwhf9iruy17dghs",
//   title: "Truffle Spaghetti",
//   description:
//       "I was planning to make a beef stew for tonight, but I got lazy midway and decided to whip up this quick carbonara instead! Quick and easy recipe (with no dumb cream)!",
//   imageUrl:
//       "https://firebasestorage.googleapis.com/v0/b/flutter-recipedia.appspot.com/o/post_placeholder.jpg?alt=media&token=620d1f8c-eb50-42a9-b407-5abbf17fc8b4",
//   likes: [],
//   comments: [
//     RecipeComment(
//       id: "6oRq4ir88zTQYjWk4CyE",
//       content: "Hello world",
//       userId: "2e29eu2idjsiud9121duud821",
//       recipeId: "G6jhfCIWfwHi1WroMtUN",
//     )
//   ],
//   ingredients: [
//     "2 teaspoons olive oil",
//     "1 pound guanciale (cured pork cheek), diced",
//     "1 (16 ounce) package spaghetti",
//     "3 eggs",
//     "10 tablespoons grated Pecorino Romano cheese, divided",
//     "salt and ground black pepper to taste"
//   ],
//   steps: [
//     "Heat olive oil in a large skillet over medium heat; add guanciale (see Cook's Note). Cook, turning occasionally, until evenly browned and crispy, 5 to 10 minutes. Remove from heat and drain on paper towels. ",
//     "Bring a large pot of salted water to a boil. Cook spaghetti in the boiling water, stirring occasionally until tender yet firm to the bite, about 9 minutes. Drain and return to the pot. Let cool, stirring occasionally, about 5 minutes.",
//     "Whisk eggs, half of the Pecorino Romano cheese, and some black pepper in a bowl until smooth and creamy.\nPour egg mixture over pasta, stirring quickly, until creamy and slightly cooled. Stir in guanciale. Top with remaining Pecorino Romano cheese and more black pepper."
//   ],
//   author: mockUser,
// );
