import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_recipedia/main.dart';

// This is the type used by the popup menu below.
enum RecipeOption { save, share }

class RecipeOptionsMenu extends StatelessWidget {
  final void Function() onSaveTapped;
  final void Function() onShareTapped;

  const RecipeOptionsMenu(
      {Key? key, required this.onSaveTapped, required this.onShareTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<RecipeOption>(
      tooltip: "More Options",
      offset: const Offset(-30, 40),
      icon: const Icon(
        Icons.more_horiz,
        size: 24,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: RecipeOption.share,
          onTap: onShareTapped,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                FeatherIcons.bookmark,
                color: Theme.of(context).primaryColorDark,
              ),
              const Text("Save"),
            ],
          ),
        ),
        PopupMenuItem(
          value: RecipeOption.share,
          onTap: onSaveTapped,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              App.shareIcon,
              const Text("Share"),
            ],
          ),
        ),
      ],
    );
  }
}
