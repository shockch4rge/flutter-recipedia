import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/user.dart';

class UserRepository {
  final CollectionReference _users;

  const UserRepository(this._users);

  Future<User> getUserById(DocumentReference userId) async {
    final snap = await userId
        .withConverter(
            fromFirestore: User.fromFirestore, toFirestore: User.toFirestore)
        .get();

    return snap.data()!;
  }

  Future<User> createUser({
    required String name,
    required String username,
  }) async {
    final userRef = _users.doc();

    await userRef
        .withConverter(
            fromFirestore: User.fromFirestore, toFirestore: User.toFirestore)
        .set(
          User(
            id: userRef,
            name: name,
            username: username,
            bio: "",
            avatarUrl:
                "https://firebasestorage.googleapis.com/v0/b/flutter-recipedia.appspot.com/o/recipedia_avatar_placeholder.png?alt=media&token=ab372ee6-b439-4566-a421-396b1e7735a2",
            following: [],
            followers: [],
          ),
        );

    return User.fromFirestore(await userRef.get(), null);
  }

  Future<List<User>> getUserFollowers(DocumentReference userId) async {
    final snap = await _users
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: User.toFirestore,
        )
        .where(User.followingField, arrayContains: userId)
        .get();

    return snap.docs.map((doc) => doc.data()).toList();
  }

  Future<List<User>> getUserFollowing(DocumentReference userId) async {
    final snap = await _users
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: User.toFirestore,
        )
        .where(User.followersField, arrayContains: userId)
        .get();

    return snap.docs.map((doc) => doc.data()).toList();
  }

  Future<void> addUserFollower(
    DocumentReference userId,
    DocumentReference followerId,
  ) async {
    await userId.update({
      User.followersField.components[0]: FieldValue.arrayUnion([followerId]),
    });
  }

  Future<void> removeUserFollower(
    DocumentReference userId,
    DocumentReference followerId,
  ) async {
    await userId.update({
      User.followersField.components[0]: FieldValue.arrayRemove([followerId]),
    });
  }

  Future<void> addUserFollowing(
    DocumentReference userId,
    DocumentReference followingId,
  ) async {
    await userId.update({
      User.followingField.components[0]: FieldValue.arrayUnion([followingId]),
    });
  }

  Future<void> removeUserFollowing(
    DocumentReference userId,
    DocumentReference followingId,
  ) async {
    await userId.update({
      User.followingField.components[0]: FieldValue.arrayRemove([followingId]),
    });
  }
}
