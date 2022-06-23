import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/users/ui/user_followers/widgets/user_follower_list_item.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:provider/provider.dart';

import '../../../../models/user.dart';
import '../../../../utils/get_args.dart';
import 'widgets/user_followers_app_bar.dart';

class UserFollowersScreen extends StatefulWidget {
  static const routeName = "/home/profile/followers";

  const UserFollowersScreen({Key? key}) : super(key: key);

  @override
  State<UserFollowersScreen> createState() => _UserFollowersScreenState();
}

class _UserFollowersScreenState extends State<UserFollowersScreen> {
  User get user => getArgs<User>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserFollowersAppBar(),
      body: FutureBuilder(
        future: context.read<UserRepository>().getUserFollowers(user.id),
        builder: (context, snap) {
          if (snap.waiting) {
            return const UserFollowerPlaceholderList();
          }

          final followers = snap.data as List<User>;

          if (followers.isEmpty) {
            return const Center(
              child: Text("You don't have any followers!"),
            );
          }

          return UserFollowerList(followers: followers);
        },
      ),
    );
  }
}

class UserFollowerPlaceholderList extends StatelessWidget {
  const UserFollowerPlaceholderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const UserFollowerPlaceholderListItem();
      },
      itemCount: 12,
    );
  }
}

class UserFollowerList extends StatelessWidget {
  final List<User> followers;

  const UserFollowerList({Key? key, required this.followers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return UserFollowerListItem(follower: followers[index]);
      },
      itemCount: followers.length,
    );
  }
}
