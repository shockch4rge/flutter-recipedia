import 'package:flutter/material.dart';

class EditRecipeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditRecipeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        "Create",
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
