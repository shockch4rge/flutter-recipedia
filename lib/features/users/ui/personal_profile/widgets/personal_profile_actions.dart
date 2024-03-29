import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/users/ui/view_liked_recipes/view_liked_recipes_screen.dart';
import 'package:flutter_recipedia/features/users/ui/view_saved_recipes/view_saved_recipes_screen.dart';
import 'package:flutter_recipedia/models/user.dart';

import '../../personal_profile_settings/personal_profile_settings_screen.dart';

class PersonalProfileActions extends StatelessWidget {
  final User user;

  const PersonalProfileActions({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 40,
            margin: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade400.withOpacity(0.7),
            ),
          ),
          Column(
            children: [
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                  PersonalProfileSettingsScreen.routeName,
                  arguments: user,
                ),
                title: Wrap(
                  spacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(Icons.settings),
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              ListTile(
                onTap: () => Navigator.of(context)
                    .pushNamed(ViewLikedRecipesScreen.routeName),
                title: Wrap(
                  spacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(Icons.favorite),
                    Text(
                      "View Liked Recipes",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              ListTile(
                onTap: () => Navigator.of(context)
                    .pushNamed(ViewSavedRecipesScreen.routeName),
                title: Wrap(
                  spacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(Icons.bookmark),
                    Text(
                      "View Saved Recipes",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
