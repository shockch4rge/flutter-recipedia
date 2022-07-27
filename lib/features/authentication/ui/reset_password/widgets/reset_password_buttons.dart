import 'package:flutter/material.dart';

class SendEmailLinkButton extends StatelessWidget {
  final void Function() onPressed;

  const SendEmailLinkButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            primary: Theme.of(context).primaryColorDark,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "SUBMIT",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}

class ResetPasswordButton extends StatelessWidget {
  final void Function() onPressed;

  const ResetPasswordButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            primary: Theme.of(context).primaryColorDark,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "RESET",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}
