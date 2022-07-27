import "package:flutter/material.dart";
import 'package:flutter_recipedia/main.dart';

class SignUpButton extends StatelessWidget {
  final void Function() onPressed;

  const SignUpButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          primary: Theme.of(context).primaryColorDark,
        ),
        onPressed: () => onPressed(),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "SIGN UP",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class GoogleSignUpButton extends StatelessWidget {
  final void Function() onPressed;

  const GoogleSignUpButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      child: ElevatedButton.icon(
        onPressed: () => onPressed(),
        icon: App.googleLogo,
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "SIGN UP WITH GOOGLE",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          elevation: 0,
          side: BorderSide(color: Theme.of(context).primaryColorDark),
          primary: Colors.white,
          onPrimary: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
      ),
    );
  }
}
