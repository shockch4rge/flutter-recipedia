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
        splashRadius: 20,
        icon: const Icon(Icons.arrow_back_ios),
        tooltip: "Back",
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
