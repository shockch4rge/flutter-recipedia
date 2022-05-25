import 'package:flutter/material.dart';

import '../widgets/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.only(top: 140, left: 30, right: 30),
          child: Column(
            children: [
              Text(
                "Welcome to recipedia.",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 84),
              const SizedBox(child: LoginForm()),
            ],
          ),
        ));
  }
}
