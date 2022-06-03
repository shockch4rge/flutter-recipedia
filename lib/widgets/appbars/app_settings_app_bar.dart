import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

class AppSettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppSettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(CupertinoIcons.arrow_left, color: App.primaryAccent),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "App Settings",
        style: TextStyle(color: App.primaryAccent),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
