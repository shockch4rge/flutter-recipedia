import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/widgets/user_following_app_bar.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/widgets/user_following_list_item.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:provider/provider.dart';

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
      body: FutureBuilder(
        future: context.read<UserRepository>().getUserFollowing(user.id),
        builder: (context, snap) {
          if (snap.waiting) {
            return const _UserFollowingPlaceholderList();
          }

          final following = snap.data as List<User>;

          if (following.isEmpty) {
            return Center(
              child: Text("You aren't following anyone!"),
            );
          }

          return _UserFollowingList(following: following);
        },
      ),
    );
  }
}

class _UserFollowingList extends StatelessWidget {
  final List<User> following;

  const _UserFollowingList({Key? key, required this.following})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return UserFollowingListItem(following: following[index]);
      },
      itemCount: following.length,
    );
  }
}

class _UserFollowingPlaceholderList extends StatelessWidget {
  const _UserFollowingPlaceholderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const UserFollowingPlaceholderListItem();
      },
      itemCount: 12,
    );
  }
}
