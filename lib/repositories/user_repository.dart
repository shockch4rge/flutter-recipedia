import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/models/user.dart';

class UserRepository {
  final CollectionReference _users;

  const UserRepository(this._users);

  Future<User> getUserByUid(String uid) async {
    final snap = await _users
        .doc(uid)
        .withConverter<User>(
          fromFirestore: User.fromFirestore,
          toFirestore: User.toFirestore,
        )
        .get();
    return snap.data()!;
  }

  Future<User> getUserById(DocumentReference userId) async {
    final snap = await userId
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: User.toFirestore,
        )
        .get();

    return snap.data()!;
  }

  Future<List<User>> getUsers(List<DocumentReference> userIds) async {
    final snaps = await Future.wait(
      userIds.map((id) => id
          .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: User.toFirestore,
          )
          .get()),
      eagerError: true,
    );
    return snaps.map((doc) => doc.data()!).toList();
  }

  Future<void> updateUser({
    required User user,
    required String name,
    required String username,
    required String bio,
    required String avatarUrl,
  }) async {
    // re-use the user's particulars if they stay the same
    await user.id.update({
      User.nameField: user.name == name ? user.name : name,
      User.usernameField: user.username == username ? user.username : username,
      User.bioField: user.bio == bio ? user.bio : bio,
      User.avatarUrlField:
          user.avatarUrl == avatarUrl ? user.avatarUrl : avatarUrl,
    });
  }

  Future<User> createUser({
    required String uid,
    required String name,
    required String username,
  }) async {
    final userRef = _users.doc(uid);

    await userRef.set({
      User.nameField: name,
      User.usernameField: username,
      User.bioField: "",
      User.avatarUrlField:
          "https://firebasestorage.googleapis.com/v0/b/flutter-recipedia.appspot.com/o/recipedia_avatar_placeholder.png?alt=media&token=ab372ee6-b439-4566-a421-396b1e7735a2",
      User.followingField: [],
      User.followersField: [],
    });

    return User.fromFirestore(await userRef.get(), null);
  }

  Future<void> deleteUser(DocumentReference userId) async {
    await userId.delete();
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
      User.followersField: FieldValue.arrayUnion([followerId]),
    });
  }

  Future<void> removeUserFollower(
    DocumentReference userId,
    DocumentReference followerId,
  ) async {
    await userId.update({
      User.followersField: FieldValue.arrayRemove([followerId]),
    });
  }

  Future<void> addUserFollowing(
    DocumentReference userId,
    DocumentReference followingId,
  ) async {
    await userId.update({
      User.followingField: FieldValue.arrayUnion([followingId]),
    });
  }

  Future<void> removeUserFollowing(
    DocumentReference userId,
    DocumentReference followingId,
  ) async {
    await userId.update({
      User.followingField: FieldValue.arrayRemove([followingId]),
    });
  }

  Future<void> saveRecipe(
    DocumentReference userId,
    DocumentReference recipeId,
  ) async {
    await userId.update({
      User.savedRecipesField: FieldValue.arrayUnion([recipeId]),
    });
  }
}
