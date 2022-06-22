import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_comments/app/recipe_comment_reply_repository.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:provider/provider.dart';

class RecipeCommentReplyExpandable extends StatefulWidget {
  final RecipeComment comment;

  const RecipeCommentReplyExpandable({Key? key, required this.comment})
      : super(key: key);

  @override
  State<RecipeCommentReplyExpandable> createState() =>
      _RecipeCommentReplyExpandableState();
}

class _RecipeCommentReplyExpandableState
    extends State<RecipeCommentReplyExpandable> {
  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;

    return FutureBuilder(
      future: context
          .read<RecipeCommentReplyRepository>()
          .getAllByCommentId(comment.id),
      builder: (context, snap) => ExpandablePanel(
        header: Text("View ${snap.data}"),
        collapsed: Text(
          comment.content,
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        expanded: Text(
          comment.content,
          softWrap: true,
        ),
        theme: ExpandableThemeData(
          tapHeaderToExpand: true,
          hasIcon: true,
        ),
      ),
    );
  }
}
