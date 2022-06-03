import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/screens/app_settings_screen.dart';

class PersonalProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Text title;
  final User user;

  const PersonalProfileAppBar(
      {Key? key, required this.title, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: title,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppSettingsScreen.routeName,
            );
          },
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
