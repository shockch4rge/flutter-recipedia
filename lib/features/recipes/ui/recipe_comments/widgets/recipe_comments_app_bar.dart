import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeCommentsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final void Function() onTitleTapped;

  const RecipeCommentsAppBar({Key? key, required this.onTitleTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        splashRadius: 20,
        icon: Icon(
          CupertinoIcons.arrow_left,
          color: Theme.of(context).primaryColorDark,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: onTitleTapped,
        child: Text(
          "Comments",
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
