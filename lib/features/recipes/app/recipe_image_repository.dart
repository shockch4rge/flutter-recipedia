import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class RecipeImageRepository {
  final storage.Reference _images;

  const RecipeImageRepository(this._images);

  Future<String> uploadImage({
    required DocumentReference recipeId,
    required File file,
  }) async {
    final ref = _images.child(recipeId.id);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
