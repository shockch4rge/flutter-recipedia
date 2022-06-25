import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter_recipedia/models/user.dart';

class AvatarRepository {
  final storage.Reference _avatars;

  const AvatarRepository(this._avatars);

  Future<String> updateAvatar({
    required DocumentReference userId,
    required File file,
  }) async {
    await _deleteAvatar(userId);
    final snap = await _avatars.child(userId.id).putFile(file);

    final avatarUrl = await snap.ref.getDownloadURL();
    await userId.update({
      User.avatarUrlField.components[0]: avatarUrl,
    });
    return avatarUrl;
  }

  Future<void> _deleteAvatar(DocumentReference userId) async {
    _avatars.child(userId.id).delete();
  }
}
