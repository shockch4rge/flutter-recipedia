// final mockUser = User(
//   id: "d12ifdh2itjwid219jsf07a",
//   name: "Lisa Hannigan",
//   username: "lisahannigan",
//   avatarUrl:
//       "https://firebasestorage.googleapis.com/v0/b/flutter-recipedia.appspot.com/o/lisapfp2.png?alt=media&token=ba5642dd-f3c4-4a04-b7b4-1911dd193634",
//   bio: "Hey! I'm Lisa Hannigan. I love making music and cooking!",
//   followers: [],
//   following: [],
// );

import '../models/user.dart';
import 'constants/firestore_collections.dart';

final mockMeId = USERS
    .withConverter<User>(
      fromFirestore: User.fromFirestore,
      toFirestore: User.toFirestore,
    )
    .doc("sOCPIiDNpxC3qlW7tzEb");

final mockMeUser = User(
  id: USERS
      .withConverter<User>(
        fromFirestore: User.fromFirestore,
        toFirestore: User.toFirestore,
      )
      .doc("sOCPIiDNpxC3qlW7tzEb"),
  name: "John Doe",
  username: "johndoe123",
  avatarUrl:
      "https://firebasestorage.googleapis.com/v0/b/flutter-recipedia.appspot.com/o/nerd.jpg?alt=media&token=df113971-b024-4b25-baed-12211cc83286",
  bio:
      "Hello I am John Doe I like to doe and john because my name is john doe!",
  followers: [],
  following: [],
);

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
