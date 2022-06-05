import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

class PersonalProfileSettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PersonalProfileSettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          CupertinoIcons.arrow_left,
          color: App.primaryAccent,
        ),
        splashRadius: 20,
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Profile Settings",
        style: TextStyle(color: App.primaryAccent),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
