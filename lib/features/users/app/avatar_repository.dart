import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter_recipedia/models/user.dart';

class AvatarRepository {
  // this is the path to the avatar folder in the storage
  final storage.Reference _avatars;

  const AvatarRepository(this._avatars);

  // returns the avatar image file for the given user
  Future<String> updateAvatar({
    required DocumentReference userId,
    required File file,
  }) async {
    // delete the existing image at the same location
    await _deleteAvatar(userId);
    // get a ref to the user and upload the new image
    final snap = await _avatars.child(userId.id).putFile(file);
    // get the url of the image
    final avatarUrl = await snap.ref.getDownloadURL();

    await userId.update({
      User.avatarUrlField: avatarUrl,
    });
    return avatarUrl;
  }

  Future<void> _deleteAvatar(DocumentReference userId) async {
    // get the avatar ref and delete it
    _avatars.child(userId.id).delete();
  }
}
