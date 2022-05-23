import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_recipedia/main.dart';

// This is the type used by the popup menu below.
enum PostOption { save, share }

class PostOptionsPopupMenu extends StatelessWidget {
  final void Function() onSaveTapped;
  final void Function() onShareTapped;

  const PostOptionsPopupMenu(
      {Key? key, required this.onSaveTapped, required this.onShareTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PostOption>(
        tooltip: "More Options",
        offset: Offset.fromDirection(90, 40),
        icon: const Icon(
          Icons.more_horiz,
          size: 24,
        ),
        itemBuilder: (context) => _buildMenuItems());
  }

  List<PopupMenuItem<PostOption>> _buildMenuItems() {
    return [
      PopupMenuItem(
        value: PostOption.share,
        onTap: onShareTapped,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(
              FeatherIcons.bookmark,
              color: App.primaryAccent,
            ),
            Text("Save"),
          ],
        ),
      ),
      PopupMenuItem(
        value: PostOption.share,
        onTap: onSaveTapped,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            App.shareIcon,
            const Text("Share"),
          ],
        ),
      ),
    ];
  }
}
