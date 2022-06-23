import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/features/users/ui/user_following/widgets/confirm_unfollow_dialog.dart';
import 'package:flutter_recipedia/models/user.dart';

class UserFollowingListItem extends StatelessWidget {
  final User following;

  const UserFollowingListItem({Key? key, required this.following})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Avatar(
              size: 40,
              avatarUrl: following.avatarUrl,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  following.username,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 4),
                Text(
                  following.name,
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
                  following: following,
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

class UserFollowingPlaceholderListItem extends StatelessWidget {
  const UserFollowingPlaceholderListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: 100,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            width: 84,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          )
        ],
      ),
    );
  }
}
