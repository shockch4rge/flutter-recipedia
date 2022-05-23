import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:flutter_recipedia/widgets/common/avatar.dart';
import 'package:flutter_recipedia/widgets/common/checkbox_list_item.dart';
import 'package:flutter_recipedia/widgets/post/post_buttons.dart';
import 'package:flutter_recipedia/widgets/view_recipe/snapping_app_bar.dart';

class ViewRecipeScreen extends StatefulWidget {
  static const String routeName = "/view-recipe";

  const ViewRecipeScreen({Key? key}) : super(key: key);

  @override
  _ViewRecipeScreenState createState() => _ViewRecipeScreenState();
}

class _ViewRecipeScreenState extends State<ViewRecipeScreen> {
  final _controller = ScrollController();

  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;
  double get maxHeight => 200 + MediaQuery.of(context).padding.top;
  Recipe get recipe => getArgs<Recipe>(context);

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
            SnappingAppBar(
                recipe: recipe, maxHeight: maxHeight, minHeight: minHeight),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildRecipeInteractions(),
                    _buildRecipeDescription(),
                    _buildRecipeDirections(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildRecipeInteractions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Avatar(
              size: 40,
              avatarUrl: recipe.author.avatarUrl,
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.author.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 3),
                Text(
                  "@${recipe.author.username}",
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            LikeButton(onPressed: () {}),
            CommentButton(onPressed: () {}),
            ShareButton(onPressed: () {}),
          ],
        )
      ],
    );
  }

  _buildRecipeDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        recipe.description,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  _buildRecipeDirections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ingredients",
          style: Theme.of(context).textTheme.headline3,
        ),
        Column(
          children: recipe.ingredients
              .map((ingredient) => CheckBoxListItem(title: ingredient))
              .toList(),
        ),
        const SizedBox(height: 20),
        Text(
          "Directions",
          style: Theme.of(context).textTheme.headline3,
        ),
        Column(
          children: recipe.steps
              .mapIndexed(
                (index, step) => Container(
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
                ),
              )
              .toList(),
        )
      ],
    );
  }

  Card _buildCard(int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Text("Item $index"),
      ),
    );
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(
        () => _controller.animateTo(snapOffset,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutCubicEmphasized),
      );
    }
  }
}