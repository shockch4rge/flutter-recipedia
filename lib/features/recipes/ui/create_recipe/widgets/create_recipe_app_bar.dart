import 'package:flutter/material.dart';

class CreateRecipeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreateRecipeAppBar({Key? key}) : super(key: key);

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
