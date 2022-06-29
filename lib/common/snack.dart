import 'package:flutter/material.dart';

// helper class to avoid boilerplate
class Snack {
  static bad(BuildContext context, String content, [SnackBarAction? action]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
          ),
        ),
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.red,
      ),
    );
  }

  static good(BuildContext context, String content, [SnackBarAction? action]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(fontFamily: "WorkSans"),
        ),
        duration: const Duration(seconds: 2),
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
