import 'package:flutter/material.dart';
import 'package:flutter_recipedia/widgets/forgot_password/reset_password_form.dart';

import '../main.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: App.primaryColor,
                    size: 16,
                  ),
                  label: const Text(
                    "Back to login",
                    style: TextStyle(
                      color: App.primaryColor,
                    ),
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 140, left: 30, right: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 300,
                    child: Text("Reset your password.",
                        style: Theme.of(context).textTheme.headline1),
                  ),
                ),
                const SizedBox(height: 58),
                Text(
                  "Enter your e-mail so we can send a password reset link. We'll sort things out from there!",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 58),
                const SizedBox(
                  child: ResetPasswordForm(),
                ),
              ],
            ),
          )
        ],
      ),
    );
    return Container();
  }
}
