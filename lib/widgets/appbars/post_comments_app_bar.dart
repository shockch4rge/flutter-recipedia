import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCommentsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PostCommentsAppBar({Key? key}) : super(key: key);

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
      title: Text(
        "Comments",
        style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
