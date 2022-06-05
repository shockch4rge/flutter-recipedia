import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

class PostFeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ScrollController controller;

  const PostFeedAppBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: () {
          controller.animateTo(
            controller.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: const Text(
          "recipedia",
          style: TextStyle(
            color: App.primaryColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
