import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  final _formKey = GlobalKey<FormBuilderState>();
  bool isExactUsername = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure you want to delete your profile?"),
      content: FormBuilder(
        key: _formKey,
        child: FormBuilderTextField(
          name: "username",
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: Colors.black,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          validator: (value) {
            if (value != widget.user.username) {
              return "Username does not match.";
            }
            return null;
          },
          onChanged: (_) {
            setState(() => isExactUsername = _formKey.currentState!.validate());
          },
          decoration: InputDecoration(
            label: Text(
              "Enter ${widget.user.username} to continue.",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.zero,
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
          onPressed: !isExactUsername
              ? null
              : () {
                  widget.onConfirm();
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
