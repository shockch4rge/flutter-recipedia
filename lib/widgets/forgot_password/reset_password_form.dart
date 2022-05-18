import 'package:flutter/material.dart';
import 'package:flutter_recipedia/widgets/forgot_password/reset_password_buttons.dart';

import '../../main.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  String _email = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hoverColor: App.primaryAccent,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(7))),
            filled: true,
            fillColor: Colors.grey.shade200,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            hintText: "johndoe@gmail.com",
            label: Text(
              "Email",
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color),
            ),
          ),
        ),
        const SizedBox(height: 58),
        ResetPasswordButton(onPressed: () {}),
      ],
    );
  }
}
