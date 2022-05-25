import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/widgets/login/login_buttons.dart';

import '../../main.dart';
import '../../utils/auth_helper.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) =>
                AuthHelper.isEmail(value!) ? null : "Wrong email!",
            onChanged: (value) => {
              if (_formKey.currentState!.validate())
                setState(() {
                  _email = value;
                })
            },
            decoration: InputDecoration(
              hoverColor: App.primaryAccent,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              hintText: "johndoe@gmail.com",
              label: Text(
                "Email",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              TextFormField(
                obscureText: true,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
                onChanged: (value) => setState(() {
                  _password = value;
                }),
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  label: Text(
                    "Password",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline3?.color,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Size.infinite.width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: App.primaryColor,
                      ),
                    ),
                    onPressed: () =>
                        // TODO: swap to pushReplacedNamed when you need to test
                        Navigator.of(context).pushNamed("/reset-password"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              Column(
                children: [
                  SignInButton(onPressed: () async {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );

                    Navigator.of(context).pushNamed("/home");
                  }),
                  SizedBox(width: Size.infinite.width, height: 10),
                ],
              ),
              GoogleSignInButton(
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextButton(
                  child: const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: App.primaryAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/signup");
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
