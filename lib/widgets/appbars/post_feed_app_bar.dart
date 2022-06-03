import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

class PostFeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostFeedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        "recipedia",
        style: TextStyle(color: App.primaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
