import 'package:flutter/material.dart';

import '../../main.dart';

class ResetPasswordButton extends StatelessWidget {
  final void Function() onPressed;

  const ResetPasswordButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0))),
            backgroundColor: MaterialStateProperty.all(App.primaryAccent),
          ),
          onPressed: () => onPressed(),
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
