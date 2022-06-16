import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalProfileSettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PersonalProfileSettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.arrow_left,
          color: Theme.of(context).primaryColorDark,
        ),
        splashRadius: 20,
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Profile Settings",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
