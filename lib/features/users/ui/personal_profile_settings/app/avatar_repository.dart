import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/utils/extensions/task_state.dart';

class AvatarRepository {
  final storage.Reference _avatars;

  const AvatarRepository(this._avatars);

  Future<void> updateAvatar({
    required DocumentReference userId,
    required File file,
  }) async {
    await _deleteAvatar(userId);
    _avatars.child(userId.id).putFile(file).snapshotEvents.listen(
      (snap) async {
        if (snap.success) {
          final avatarUrl = await snap.ref.getDownloadURL();
          await userId.update({
            User.avatarUrlField.components[0]: avatarUrl,
          });
          print("updated avatar!");
          return;
        }

        if (snap.error) {
          return;
        }
      },
      cancelOnError: true,
      onError: (e) {},
    );
  }

  Future<void> _deleteAvatar(DocumentReference userId) async {
    _avatars.child(userId.id).delete();
  }
}
