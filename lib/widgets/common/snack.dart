import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

class Snack {
  static bad(BuildContext context, String content, [SnackBarAction? action]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.red,
      ),
    );
  }

  static good(BuildContext context, String content, SnackBarAction? action) {
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
        backgroundColor: App.primaryColor,
      ),
    );
  }
}
