import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/user.dart';

class UserRepository {
  final CollectionReference _users;

  const UserRepository(this._users);

  Future<User> getUserById(DocumentReference userId) async {
    final snap = await userId
        .withConverter<User>(
          fromFirestore: User.fromFirestore,
          toFirestore: User.toFirestore,
        )
        .get();

    return snap.data()!;
  }

  Future<User> createUser({
    required String name,
    required String username,
  }) async {
    final userRef = await _users.add({
      "name": name,
      "username": username,
      "bio": "",
      "avatarUrl":
          "https://firebasestorage.googleapis.com/v0/b/flutter-recipedia.appspot.com/o/recipedia_avatar_placeholder.png?alt=media&token=ab372ee6-b439-4566-a421-396b1e7735a2",
    });

    return User.fromFirestore(await userRef.get(), null);
  }

  Future<List<User>> getFollowers(DocumentReference userId) async {
    final snap = await userId.get();
    List<DocumentReference> followers = snap.get("followers");

    return Future.wait(followers.map((f) async {
      final snap = await f
          .withConverter(
              fromFirestore: User.fromFirestore, toFirestore: User.toFirestore)
          .get();

      return snap.data()!;
    }));
  }
}
