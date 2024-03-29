import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class CommentButton extends StatelessWidget {
  final int count;
  final void Function() onPressed;

  const CommentButton({Key? key, required this.count, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        elevation: 0,
        primary: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      icon: App.chatBubbleIcon,
      label: Text(
        count.toString(),
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  final List<DocumentReference> likes;
  final void Function() onPressed;

  const LikeButton({Key? key, required this.likes, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        elevation: 0,
        primary: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      icon: App.heartOutlinedIcon,
      label: Text(
        likes.length.toString(),
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  final void Function() onPressed;

  const ShareButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          elevation: 0,
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: App.shareIcon,
      ),
    );
  }
}

class ViewRecipeButton extends StatelessWidget {
  final void Function() onPressed;

  const ViewRecipeButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).primaryColor
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 90.0,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: const Text(
            "View Recipe",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
