import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserFollowingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const UserFollowingAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        splashRadius: 20,
        icon: Icon(
          CupertinoIcons.arrow_left,
          color: Theme.of(context).primaryColorDark,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Following",
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
