import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/screens/home/personal_profile/personal_profile_settings_screen.dart';

class PersonalProfileActions extends StatelessWidget {
  const PersonalProfileActions({Key? key}) : super(key: key);

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
              color: Colors.grey.shade300,
            ),
          ),
          Column(
            children: [
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                  PersonalProfileSettingsScreen.routeName,
                ),
                title: Wrap(
                  spacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(Icons.settings),
                    Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(""),
                title: Wrap(
                  spacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.favorite),
                    Text(
                      "View Liked Recipes",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(""),
                title: Wrap(
                  spacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(Icons.bookmark),
                    Text(
                      "View Saved Recipes",
                      style: TextStyle(color: Colors.black),
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
