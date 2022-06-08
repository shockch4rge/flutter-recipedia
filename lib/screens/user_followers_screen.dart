import 'package:flutter/material.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:flutter_recipedia/widgets/appbars/user_followers_app_bar.dart';
import 'package:flutter_recipedia/widgets/common/avatar.dart';
import 'package:flutter_recipedia/widgets/dialogs/confirm_remove_follower_dialog.dart';

import '../models/user.dart';

class UserFollowersScreen extends StatefulWidget {
  static const routeName = "/home/profile/followers";

  const UserFollowersScreen({Key? key}) : super(key: key);

  @override
  State<UserFollowersScreen> createState() => _UserFollowersScreenState();
}

class _UserFollowersScreenState extends State<UserFollowersScreen> {
  get user => getArgs<User>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserFollowersAppBar(),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _FollowerListItem(user: user);
        },
      ),
    );
  }
}

class _FollowerListItem extends StatelessWidget {
  final User user;

  const _FollowerListItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Avatar(
              size: 40,
              avatarUrl: "assets/images/avatar_placeholder.png",
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 4),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) {
                return ConfirmRemoveFollowerDialog(
                  user: user,
                  onConfirm: () {
                    print("onConfirm remove");
                  },
                );
              },
            ),
            child: const Text(
              "Remove",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Theme.of(context).primaryColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
