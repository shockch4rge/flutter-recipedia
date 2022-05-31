import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

class Snack {
  Snack.bad(BuildContext context, String content, [SnackBarAction? action]) {
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

  Snack.good(BuildContext context, String content, SnackBarAction? action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(fontFamily: "WorkSans"),
        ),
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: App.primaryColor,
      ),
    );
  }
}
