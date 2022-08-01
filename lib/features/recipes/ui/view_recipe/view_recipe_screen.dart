import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/common/checkbox_list_item.dart';
import 'package:flutter_recipedia/features/users/ui/user_profile/user_profile_screen.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:provider/provider.dart';

import '../../app/recipe_comment_repository.dart';
import '../common/recipe_buttons.dart';
import '../recipe_comments/recipe_comments_screen.dart';
import 'widgets/view_recipe_app_bar.dart';

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

  late final getUser = context.read<UserRepository>().getUserById;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _snapAppbar();
          return false;
        },
        child: FutureBuilder(
          future: getUser(recipe.authorId),
          builder: (context, snap) {
            if (snap.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final user = snap.data as User;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              slivers: [
                ViewRecipeAppBar(
                  recipe: recipe,
                  maxHeight: maxHeight,
                  minHeight: minHeight,
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _RecipeActions(recipe: recipe, user: user),
                        _RecipeDescription(recipe: recipe),
                        _RecipeDirections(recipe: recipe),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
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

class _RecipeDescription extends StatelessWidget {
  final Recipe recipe;

  const _RecipeDescription({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        recipe.description,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

class _RecipeActions extends StatelessWidget {
  final Recipe recipe;
  final User user;

  const _RecipeActions({Key? key, required this.recipe, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            UserProfileScreen.routeName,
            arguments: user,
          ),
          child: Row(
            children: [
              Avatar(
                size: 40,
                avatarUrl: user.avatarUrl,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "@${user.username}",
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  )
                ],
              )
            ],
          ),
        ),
        Row(
          children: [
            LikeButton(
              likes: recipe.likes,
              onPressed: () {
                context.read<RecipeRepository>().addLike(
                      recipeId: recipe.id,
                      likerId: user.id,
                    );
              },
            ),
            StreamBuilder(
              stream: context
                  .read<RecipeCommentRepository>()
                  .getCommentCountByRecipeId(recipe.id),
              builder: (context, snap) {
                if (snap.waiting) {
                  return Container();
                }

                final commentCount = snap.data as int;
                return CommentButton(
                  count: commentCount,
                  onPressed: () => Navigator.of(context).pushNamed(
                    RecipeCommentsScreen.routeName,
                    arguments: recipe.id,
                  ),
                );
              },
            ),
            ShareButton(onPressed: () {}),
          ],
        )
      ],
    );
  }
}

class _RecipeDirections extends StatelessWidget {
  final Recipe recipe;

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
        Wrap(
          runSpacing: 4,
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
        const SizedBox(height: 20),
        Text(
          "Notes",
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 6),
        Text(
          recipe.notes.isEmpty ? "No added notes." : recipe.notes,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
