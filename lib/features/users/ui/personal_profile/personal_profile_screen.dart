import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/recipe_preview.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/personal_profile_settings_screen.dart';
import 'package:flutter_recipedia/features/users/ui/user_followers/user_followers_screen.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/user_following_screen.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';

import 'widgets/personal_profile_actions.dart';
import 'widgets/personal_profile_app_bar.dart';

class PersonalProfileScreen extends StatefulWidget {
  static const routeName = "/home/profile/me/settings";

  const PersonalProfileScreen({Key? key}) : super(key: key);

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  User get user => mockMeUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersonalProfileAppBar(
        user: mockMeUser,
        onMoreSettingsPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            builder: (_) => const PersonalProfileActions(),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: _UserDescription(user: user),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Text(
                "${user.username}'s posts",
                textAlign: TextAlign.center,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return RecipePreview(recipe: mockRecipe);
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserDescription extends StatelessWidget {
  final User user;

  const _UserDescription({Key? key, required this.user}) : super(key: key);

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
            Avatar(size: 64, avatarUrl: user.avatarUrl),
            Wrap(
              spacing: 14,
              children: [
                Column(
                  children: [
                    Text(
                      "${0}",
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
        Column(
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
        const SizedBox(height: 16),
        SizedBox(
          width: Size.infinite.width,
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              PersonalProfileSettingsScreen.routeName,
              arguments: user,
            ),
            child: Text(
              "EDIT PROFILE",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
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
