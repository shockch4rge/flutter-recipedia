import 'package:flutter/material.dart';

import 'signup_buttons.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hoverColor: Theme.of(context).primaryColorDark,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            hintText: "John Doe",
            label: Text(
              "Full Name",
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            hoverColor: Theme.of(context).primaryColorDark,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            hintText: "JohnDoe123",
            label: Text(
              "Username",
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            hoverColor: Theme.of(context).primaryColorDark,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
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
        TextFormField(
          decoration: InputDecoration(
            hoverColor: Theme.of(context).primaryColorDark,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            label: Text(
              "Password",
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            SignUpButton(
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            GoogleSignUpButton(
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
