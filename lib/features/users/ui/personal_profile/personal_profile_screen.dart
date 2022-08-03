import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/common/keep_alive_stateful.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/recipe_preview.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/personal_profile_settings_screen.dart';
import 'package:flutter_recipedia/features/users/ui/user_followers/user_followers_screen.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/user_following_screen.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:provider/provider.dart';

import 'widgets/personal_profile_actions.dart';
import 'widgets/personal_profile_app_bar.dart';

class PersonalProfileScreen extends KeepAliveStateful {
  static const routeName = "/home/profile/me/settings";

  const PersonalProfileScreen({Key? key}) : super(key: key);

  @override
  KeepAliveState createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends KeepAliveState {
  late final user = context.read<AuthProvider>().user!;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: context.read<UserRepository>().getUserById(user.id),
        builder: (context, snap) {
          if (snap.waiting) {
            return Container();
          }

          final user = snap.data as User;

          return Scaffold(
            appBar: PersonalProfileAppBar(
              user: user,
              onMoreSettingsPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  builder: (_) => PersonalProfileActions(user: user),
                );
              },
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  FutureBuilder(
                      future: context
                          .read<RecipeRepository>()
                          .getUserRecipes(user.id),
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
                      child: const Text(
                        "Your Recipes",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: context
                        .read<RecipeRepository>()
                        .getUserRecipes(user.id),
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
        });
  }
}

class _UserDescription extends StatelessWidget {
  final User user;
  final int recipesCount;

  const _UserDescription(
      {Key? key, required this.user, required this.recipesCount})
      : super(key: key);

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
            Avatar(size: 80, avatarUrl: user.avatarUrl),
            Wrap(
              spacing: 14,
              children: [
                Column(
                  children: [
                    Text(
                      "$recipesCount",
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
                    arguments: user,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${user.followers.length}",
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
                    arguments: user,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${user.following.length}",
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
                user.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 10),
              Text(user.bio, style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: Size.infinite.width,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              PersonalProfileSettingsScreen.routeName,
              arguments: user,
            ),
            child: Text(
              "EDIT PROFILE",
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).primaryColorDark),
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
