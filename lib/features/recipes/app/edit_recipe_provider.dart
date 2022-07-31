import 'dart:io';

import 'package:flutter/material.dart';

class EditRecipeProvider with ChangeNotifier {
  File? uploadedImage;
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

  void reorderStep(int oldIndex, int newIndex) {
    final step = steps.removeAt(oldIndex);
    steps.insert(
      newIndex < oldIndex ? newIndex : newIndex - 1,
      step,
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

  void reorderIngredient(int oldIndex, int newIndex) {
    final ingredient = ingredients.removeAt(oldIndex);
    ingredients.insert(
      newIndex < oldIndex ? newIndex : newIndex - 1,
      ingredient,
    );
    notifyListeners();
  }

  void reset() {
    setUploadedImage(null);
    steps.clear();
    ingredients.clear();
    uploadedImage?.delete();
  }
}
