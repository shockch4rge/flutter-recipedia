import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserFollowersAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const UserFollowersAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.arrow_left,
          color: Theme.of(context).primaryColorDark,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Followers",
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
