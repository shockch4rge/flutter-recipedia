import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CreateRecipeProvider with ChangeNotifier {
  File? uploadedImage;
  List<String> addedIngredients = [];

  void setUploadedImage(File? file) {
    uploadedImage = file;
    notifyListeners();
  }

  void addIngredient(String ingredient) {
    addedIngredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(int index) {
    addedIngredients.removeAt(index);
    notifyListeners();
  }

  void reorderIngredient(int oldIndex, int newIndex) {
    addedIngredients.swap(oldIndex, newIndex);
    notifyListeners();
  }

  void reset() {
    setUploadedImage(null);
    uploadedImage?.delete();
  }
}
