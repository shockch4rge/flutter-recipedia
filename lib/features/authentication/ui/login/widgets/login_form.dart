import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/authentication/ui/reset_password/reset_password_screen.dart';
import 'package:flutter_recipedia/features/authentication/ui/signup/signup_screen.dart';
import 'package:flutter_recipedia/features/misc/home_screen.dart';

import 'login_buttons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  // controllers to manage text field state
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  bool disableSignInButton = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) {
              return value!.length == 3 ? null : "Invalid email.";
            },
            onChanged: (value) => {
              if (_formKey.currentState!.validate()) {},
            },
            decoration: InputDecoration(
              hoverColor: Theme.of(context).primaryColorDark,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(7),
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
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => _showPassword = !_showPassword);
                    },
                    color: Colors.black45,
                    icon: const Icon(Icons.lock),
                  ),
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
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pushNamed(
                      ResetPasswordScreen.routeName,
                    ),
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
                  SignInButton(
                    onPressed: () async {
                      Navigator.of(context).pushReplacementNamed(
                        HomeScreen.routeName,
                      );
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width, height: 8),
                ],
              ),
              GoogleSignInButton(
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextButton(
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SignUpScreen.routeName),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
