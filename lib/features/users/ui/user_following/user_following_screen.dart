import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/widgets/confirm_unfollow_dialog.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/widgets/user_following_app_bar.dart';
import 'package:flutter_recipedia/utils/get_args.dart';

import '../../../../models/user.dart';

class UserFollowingScreen extends StatefulWidget {
  static const routeName = "/home/profile/following";

  const UserFollowingScreen({Key? key}) : super(key: key);

  @override
  State<UserFollowingScreen> createState() => _UserFollowingScreenState();
}

class _UserFollowingScreenState extends State<UserFollowingScreen> {
  get user => getArgs<User>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserFollowingAppBar(),
      body: ListView.builder(itemBuilder: (context, index) {
        return _FollowingListItem(user: user);
      }),
    );
  }
}

class _FollowingListItem extends StatelessWidget {
  final User user;

  const _FollowingListItem({Key? key, required this.user}) : super(key: key);

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
                return ConfirmUnfollowDialog(
                  user: user,
                  onConfirm: () {
                    print("onConfirm unfollow");
                  },
                );
              },
            ),
            child: const Text(
              "Unfollow",
              style: TextStyle(fontSize: 12),
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
