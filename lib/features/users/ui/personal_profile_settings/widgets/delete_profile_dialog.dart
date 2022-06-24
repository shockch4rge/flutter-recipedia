import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/user.dart';

class DeleteProfileDialog extends StatefulWidget {
  final User user;
  final void Function() onConfirm;

  const DeleteProfileDialog(
      {Key? key, required this.user, required this.onConfirm})
      : super(key: key);

  @override
  State<DeleteProfileDialog> createState() => _DeleteProfileDialogState();
}

class _DeleteProfileDialogState extends State<DeleteProfileDialog> {
  bool _isExactUsername = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure you want to delete your profile?"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          cursorColor: Colors.black,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          validator: (value) {
            if (value != widget.user.username) {
              return "";
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text(
              "Enter ${widget.user.username} to continue.",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.zero,
          ),
          onTap: () => _formKey.currentState!.validate(),
          onChanged: (_) => setState(
            () => _isExactUsername = _formKey.currentState!.validate(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel"),
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
        ),
        TextButton(
          onPressed: !_isExactUsername
              ? null
              : () {
                  Navigator.of(context).pop();
                },
          child: Text("Delete"),
          style: TextButton.styleFrom(
            primary: Colors.red,
          ),
        )
      ],
    );
  }
}
