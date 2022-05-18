import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/recipe.dart';

class PostScroller extends StatelessWidget {
  final List<Recipe> recipes;

  const PostScroller({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ListView.builder(itemBuilder: (BuildContext builder, int index) {
        return Container();
      });
}
