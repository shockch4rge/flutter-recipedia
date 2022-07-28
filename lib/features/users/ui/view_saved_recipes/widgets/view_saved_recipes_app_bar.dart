import 'package:flutter/material.dart';

class ViewSavedRecipesAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ViewSavedRecipesAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        tooltip: "Back",
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        "Saved Recipes",
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 16,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
