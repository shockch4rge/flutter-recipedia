import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/checkbox_list_item.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../view_searched_recipe/widgets/view_searched_recipe_app_bar.dart';

class ViewSearchedRecipeScreen extends StatefulWidget {
  static const String routeName = "/home/search/view-recipe";

  const ViewSearchedRecipeScreen({Key? key}) : super(key: key);

  @override
  _ViewSearchedRecipeScreenState createState() =>
      _ViewSearchedRecipeScreenState();
}

class _ViewSearchedRecipeScreenState extends State<ViewSearchedRecipeScreen> {
  final _controller = ScrollController();

  late final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
  late final maxHeight = 200 + MediaQuery.of(context).padding.top;
  late final recipe = getArgs<SpoonacularRecipe>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _snapAppbar();
          return false;
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          slivers: [
            ViewSearchedRecipeAppBar(
              recipe: recipe,
              maxHeight: maxHeight,
              minHeight: minHeight,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RecipeDirections(recipe: recipe),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(
        () => _controller.animateTo(
          snapOffset,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutCubicEmphasized,
        ),
      );
    }
  }
}

class _RecipeDirections extends StatelessWidget {
  final SpoonacularRecipe recipe;

  const _RecipeDirections({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ingredients",
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 6),
        ValueListenableBuilder<Box>(
          valueListenable: Hive.box("ingredientsChecklist").listenable(),
          builder: (context, box, widget) {
            return Wrap(
              runSpacing: 4,
              children: recipe.ingredients
                  .mapIndexed(
                    (index, ingredient) => CheckBoxListItem(
                      title: ingredient,
                      onChanged: (value) {
                        box.put(
                          "recipe-spoon-${recipe.id}-ingredient-$index",
                          value,
                        );
                      },
                      checked: box.get(
                        "recipe-spoon-${recipe.id}-ingredient-$index",
                        defaultValue: false,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 20),
        Text(
          "Directions",
          style: Theme.of(context).textTheme.headline3,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recipe.steps.mapIndexed((index, step) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step ${index + 1}:",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    step,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
