import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/user.dart';

class UserProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final void Function() onMoreSettingsPressed;

  const UserProfileAppBar(
      {Key? key, required this.user, required this.onMoreSettingsPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        user.username,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 16,
        ),
      ),
      leading: IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        tooltip: "Back",
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          onPressed: onMoreSettingsPressed,
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          splashRadius: 24,
          tooltip: "Profile Actions",
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
