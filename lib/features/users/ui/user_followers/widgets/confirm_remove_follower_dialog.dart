import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/snack.dart';
import 'package:flutter_recipedia/models/user.dart';

class ConfirmRemoveFollowerDialog extends StatelessWidget {
  final User follower;
  final void Function() onConfirm;

  const ConfirmRemoveFollowerDialog(
      {Key? key, required this.follower, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Remove ${follower.username}"),
      content: Text.rich(
        TextSpan(
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            const TextSpan(text: "Are you sure you want to remove"),
            TextSpan(
              text: " ${follower.username} ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: "from your followers?")
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
            Snack.good(context, "Removed ${follower.username}");
            onConfirm();
          },
          child: const Text("Remove"),
          style: TextButton.styleFrom(primary: Colors.red),
        ),
      ],
    );
  }
}
