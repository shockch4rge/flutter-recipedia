import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/widgets/common/snack.dart';

class ConfirmUnfollowDialog extends StatelessWidget {
  final User user;
  final void Function() onConfirm;

  const ConfirmUnfollowDialog(
      {Key? key, required this.user, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Unfollow ${user.username}"),
      content: Text.rich(
        TextSpan(
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            const TextSpan(text: "Are you sure you want to unfollow "),
            TextSpan(
              text: user.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: "?"),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Snack.good(context, "Unfollowed ${user.username}");
            onConfirm();
          },
          child: const Text("Unfollow"),
          style: TextButton.styleFrom(primary: Colors.red),
        ),
      ],
    );
  }
}
