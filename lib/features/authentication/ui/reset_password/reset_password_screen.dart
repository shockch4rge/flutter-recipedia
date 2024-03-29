import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/authentication/ui/login/login_screen.dart';
import 'package:flutter_recipedia/features/authentication/ui/reset_password/widgets/reset_password_forms.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = "/reset-password";

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
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                icon: Icon(Icons.arrow_back_ios, size: 16),
                label: Text("Back to login"),
              ),
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
                    child: Text(
                      "Reset your password.",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                const SizedBox(height: 58),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter the code sent to your email.",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(height: 18),
                const SizedBox(child: ResetPasswordForm()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
