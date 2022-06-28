import 'package:flutter/material.dart';

class ResetRecipeDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const ResetRecipeDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Reset Draft"),
      content: Text(
        "Are you sure you want to reset your recipe draft?",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
          style: TextButton.styleFrom(
            primary: Colors.red,
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text("Confirm"),
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
