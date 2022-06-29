import 'dart:io';

import 'package:flutter/material.dart';

class CreateRecipeProvider with ChangeNotifier {
  // the current image that could be uploaded
  File? uploadedImage;
  // this is used to keep track of ingredients and steps when creating a recipe
  List<String> ingredients = [];
  List<String> steps = [];

  void addStep(String step) {
    steps.add(step);
    notifyListeners();
  }

  void removeStep(int index) {
    steps.removeAt(index);
    notifyListeners();
  }

  // swap the item in the reorderable list with the item in the given index
  void reorderStep(int oldIndex, int newIndex) {
    final step = steps.removeAt(oldIndex);
    steps.insert(
      newIndex < oldIndex ? newIndex : newIndex - 1,
      step,
    );
    notifyListeners();
  }

  void reorderIngredient(int oldIndex, int newIndex) {
    final ingredient = ingredients.removeAt(oldIndex);
    ingredients.insert(
      newIndex < oldIndex ? newIndex : newIndex - 1,
      ingredient,
    );
    notifyListeners();
  }

  void setUploadedImage(File? file) {
    uploadedImage = file;
    notifyListeners();
  }

  void addIngredient(String ingredient) {
    ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(int index) {
    ingredients.removeAt(index);
    notifyListeners();
  }

  void reset() {
    setUploadedImage(null);
    steps.clear();
    ingredients.clear();
    uploadedImage?.delete();
  }
}
