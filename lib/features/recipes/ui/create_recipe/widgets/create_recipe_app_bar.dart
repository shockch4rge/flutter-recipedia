import 'package:flutter/material.dart';

// we implement PreferredSizeWidget as we need to specify the height of the AppBar
// we're returning in the build method.
class CreateRecipeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onResetPressed;

  const CreateRecipeAppBar({Key? key, required this.onResetPressed})
      : super(key: key);

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
      actions: [
        TextButton(
          onPressed: onResetPressed,
          child: Text("Reset"),
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
