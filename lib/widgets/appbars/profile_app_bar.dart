import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;

  const ProfileAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: title,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            color: App.primaryAccent,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
