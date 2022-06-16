import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppSettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 10,
      backgroundColor: Colors.white,
      title: Text(
        "App Settings",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
