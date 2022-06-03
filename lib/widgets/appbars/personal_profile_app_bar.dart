import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/user.dart';

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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}