import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/features/users/ui/user_profile/user_profile_screen.dart';
import 'package:flutter_recipedia/models/user.dart';

class UserSearchResult extends StatelessWidget {
  final User user;

  const UserSearchResult({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            UserProfileScreen.routeName,
            arguments: user,
          );
        },
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Avatar(
            size: 42,
            avatarUrl: user.avatarUrl,
          ),
          title: Text(
            user.username,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
    );
  }
}
