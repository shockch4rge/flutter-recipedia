import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/common/snack.dart';
import 'package:flutter_recipedia/features/recipes/ui/edit_recipe/edit_recipe_screen.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_comments/recipe_comments_screen.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_feed/widgets/recipe_options_menu.dart';
import 'package:flutter_recipedia/features/users/ui/user_profile/user_profile_screen.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:provider/provider.dart';

import '../../../app/recipe_comment_repository.dart';
import '../../common/recipe_buttons.dart';
import '../../view_recipe/view_recipe_screen.dart';

class _RecipeContentHeader extends StatefulWidget {
  final Recipe recipe;
  final User author;
  const _RecipeContentHeader({
    Key? key,
    required this.recipe,
    required this.author,
  }) : super(key: key);

  @override
  State<_RecipeContentHeader> createState() => _RecipeContentHeaderState();
}

class _RecipeContentHeaderState extends State<_RecipeContentHeader> {
  late final user = context.read<AuthProvider>().user!;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () => Navigator.of(context).pushNamed(
              UserProfileScreen.routeName,
              arguments: widget.author,
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            icon: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Avatar(
                size: 36,
                avatarUrl: widget.author.avatarUrl,
              ),
            ),
            label: Text(
              widget.author.username,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          RecipeOptionsMenu(
            isRecipeSaved: user.savedRecipes.contains(widget.recipe.id),
            onSaveTapped: () async {
              await context.read<UserRepository>().saveRecipe(
                    user.id,
                    widget.recipe.id,
                  );
              Snack.good(context, "Recipe saved!");
            },
            onShareTapped: () {},
            onEditTapped: widget.recipe.authorId == user.id
                ? () => Navigator.of(context).pushNamed(
                      EditRecipeScreen.routeName,
                      arguments: widget.recipe,
                    )
                : null,
          ),
        ],
      ),
    );
  }
}

class _RecipeContentHeroImage extends StatelessWidget {
  final String imageUrl;

  const _RecipeContentHeroImage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey.shade200,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}

class RecipeContent extends StatelessWidget {
  final Recipe recipe;

  const RecipeContent({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserRepository>().getUserById(recipe.authorId),
      builder: (context, snap) {
        if (snap.waiting) {
          return Container();
        }

        final author = snap.data as User;

        return Column(
          children: [
            _RecipeContentHeader(recipe: recipe, author: author),
            _RecipeContentHeroImage(imageUrl: recipe.imageUrl),
            Container(
              padding: const EdgeInsets.only(left: 22, right: 22, bottom: 30),
              child: Column(
                children: [
                  _RecipeContentActions(recipe: recipe, author: author),
                  _RecipeContentDescription(recipe: recipe, author: author),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RecipeContentActions extends StatelessWidget {
  final Recipe recipe;
  final User author;

  const _RecipeContentActions({
    Key? key,
    required this.recipe,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LikeButton(
                  likes: recipe.likes,
                  onPressed: () {},
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
                ShareButton(
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
            child: ViewRecipeButton(
              onPressed: () => Navigator.of(context).pushNamed(
                ViewRecipeScreen.routeName,
                arguments: recipe,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeContentDescription extends StatelessWidget {
  final Recipe recipe;
  final User author;

  const _RecipeContentDescription({
    Key? key,
    required this.recipe,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipe.title,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 14),
          Text(
            "${author.username}:",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          const SizedBox(height: 8),
          Text(
            recipe.description,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

class RecipeContentPlaceholder extends StatelessWidget {
  const RecipeContentPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.only(right: 14),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              Container(
                width: 180,
                height: 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 40),
          color: Colors.grey,
        )
      ],
    );
  }
}
