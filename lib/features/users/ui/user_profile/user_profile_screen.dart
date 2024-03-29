import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/recipe_preview.dart';
import 'package:flutter_recipedia/features/users/ui/user_followers/user_followers_screen.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/user_following_screen.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:provider/provider.dart';

import 'widgets/user_profile_app_bar.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = "/home/profile/user/settings";

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late final user = getArgs<User>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserProfileAppBar(
        user: user,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            FutureBuilder(
                future:
                    context.read<RecipeRepository>().getUserRecipes(user.id),
                builder: (context, snap) {
                  if (snap.waiting) return SliverToBoxAdapter();

                  final recipes = snap.data as List<Recipe>;

                  return SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: _UserDescription(
                        user: user,
                        recipesCount: recipes.length,
                      ),
                    ),
                  );
                }),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "${user.username}'s Recipes",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            FutureBuilder(
              future: context.read<RecipeRepository>().getUserRecipes(user.id),
              builder: (context, snap) {
                if (snap.waiting) {
                  return const _RecipePreviewPlaceholderSliverGrid();
                }

                final recipes = snap.data as List<Recipe>;

                if (recipes.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text("You don't have any recipes posted!"),
                    ),
                    hasScrollBody: false,
                  );
                }

                return _RecipePreviewSliverGrid(
                  recipes: recipes,
                  user: user,
                );
              },
            ),
          ],
        ),
      ),
    );
    // });
  }
}

class _UserDescription extends StatefulWidget {
  final User user;
  final int recipesCount;

  const _UserDescription(
      {Key? key, required this.user, required this.recipesCount})
      : super(key: key);

  @override
  State<_UserDescription> createState() => _UserDescriptionState();
}

class _UserDescriptionState extends State<_UserDescription> {
  late final currentUser = context.read<AuthProvider>().user!;

  @override
  Widget build(BuildContext context) {
    final countTextStyle = TextStyle(
      color: Theme.of(context).primaryColorDark,
      fontSize: 18,
      fontWeight: FontWeight.w800,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Avatar(size: 80, avatarUrl: widget.user.avatarUrl),
            Wrap(
              spacing: 14,
              children: [
                Column(
                  children: [
                    Text(
                      "${widget.recipesCount}",
                      style: countTextStyle,
                    ),
                    Text(
                      "Posts",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    UserFollowersScreen.routeName,
                    arguments: widget.user,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${widget.user.followers.length}",
                        style: countTextStyle,
                      ),
                      Text(
                        "Followers",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    UserFollowingScreen.routeName,
                    arguments: widget.user,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${widget.user.following.length}",
                        style: countTextStyle,
                      ),
                      Text(
                        "Following",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 10),
              Text(widget.user.bio,
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: Size.infinite.width,
          child: ElevatedButton(
            onPressed: () async {
              if (widget.user.followers.contains(currentUser.id)) {
                await context
                    .read<UserRepository>()
                    .removeUserFollower(widget.user.id, currentUser.id);
                return;
              }

              context
                  .read<UserRepository>()
                  .addUserFollower(widget.user.id, currentUser.id);
            },
            child: Text(
              widget.user.followers.contains(currentUser.id)
                  ? "UNFOLLOW"
                  : "FOLLOW",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.white,
              onPrimary: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColorDark),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RecipePreviewSliverGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final User user;

  const _RecipePreviewSliverGrid(
      {Key? key, required this.recipes, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => RecipePreview(recipe: recipes[index], user: user),
        childCount: recipes.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
    );
  }
}

class _RecipePreviewPlaceholderSliverGrid extends StatelessWidget {
  const _RecipePreviewPlaceholderSliverGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey,
            ),
          );
        },
        childCount: 12,
      ),
    );
  }
}
