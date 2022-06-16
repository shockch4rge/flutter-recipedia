import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String name;
  final String avatarUrl;
  final String bio;
  final List<User> followers;
  final List<User> following;
  // final String email;

  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      username: doc.get("username"),
      name: doc.get("name"),
      bio: doc.get("bio"),
      avatarUrl: doc.get("avatarUrl"),
      following: [],
      followers: [],
    );
  }
}
