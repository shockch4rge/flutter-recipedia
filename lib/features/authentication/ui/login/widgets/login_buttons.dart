import 'package:flutter/material.dart';

class SignInButton extends StatefulWidget {
  final bool disabled;
  final void Function() onPressed;

  const SignInButton({Key? key, required this.onPressed, this.disabled = false})
      : super(key: key);

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColorDark),
        ),
        onPressed: widget.disabled ? null : widget.onPressed,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "SIGN IN",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final void Function() onPressed;

  const GoogleSignInButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      child: ElevatedButton.icon(
        onPressed: () => onPressed(),
        icon: const FlutterLogo(),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "SIGN IN WITH GOOGLE",
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
          onPrimary: Theme.of(context).primaryColor.withOpacity(0.1),
          primary: Colors.white,
        ),
      ),
    );
  }
}
