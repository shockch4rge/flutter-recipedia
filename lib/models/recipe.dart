class Recipe {
  final String title;
  final String description;
  /*
  final String imageUrl;
  final List<String> tags;
  final List<RecipeIngredient> ingredients;
   */

  const Recipe({required this.title, required this.description});
}

class RecipeIngredient {
  final String content;
  final double amount;
  final String measurement;

  const RecipeIngredient(
      {required this.content, required this.amount, required this.measurement});
}
