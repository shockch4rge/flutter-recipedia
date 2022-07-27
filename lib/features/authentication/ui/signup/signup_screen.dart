import 'package:flutter/material.dart';

import './widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signup";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 80.0, left: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                label: const Text("Back to login"),
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
                      "Sign up for an account.",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const SizedBox(child: SignUpForm()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
