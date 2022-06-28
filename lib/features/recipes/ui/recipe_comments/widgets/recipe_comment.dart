import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/features/recipes/app/recipe_comment_repository.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_comments/widgets/recipe_comment_reply_expandable.dart';
import 'package:flutter_recipedia/models/recipe.dart' as model;
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/shorten_number.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../models/user.dart';

class RecipeComment extends StatelessWidget {
  final model.RecipeComment comment;
  final void Function(User author) onReply;

  const RecipeComment({Key? key, required this.onReply, required this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserRepository>().getUserById(comment.authorId),
      builder: (context, snap) {
        if (snap.waiting) {
          return Container();
        }

        final author = snap.data as User;

        return Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            closeThreshold: 0.1,
            extentRatio: 0.45,
            children: [
              SlidableAction(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                onPressed: (_) => onReply(author),
                icon: CupertinoIcons.arrow_turn_up_left,
              ),
              SlidableAction(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                onPressed: (_) => _toggleLike(context, author.id),
                icon: FontAwesomeIcons.heart,
              ),
              SlidableAction(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                onPressed: (_) {
                  // TODO: delete comment
                  print("Delete tapped");
                },
                icon: CupertinoIcons.delete_simple,
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Avatar(
                    size: 40,
                    avatarUrl: author.avatarUrl,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author.username,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        comment.content,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      RecipeCommentReplyExpandable(comment: comment),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "${shortenNumber(comment.likes.length)} likes",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () => onReply(author),
                            child: const Text(
                              "Reply",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => _toggleLike(context, author.id),
                    splashRadius: 18,
                    icon: Icon(
                      comment.likes.contains(author.id)
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      size: 18,
                      color: comment.likes.contains(author.id)
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _toggleLike(
      BuildContext context, DocumentReference userId) async {
    if (comment.likes.contains(userId)) {
      await context.read<RecipeCommentRepository>().removeLike(
            commentId: comment.id,
            likerId: userId,
          );
      return;
    }

    context.read<RecipeCommentRepository>().addLike(
          commentId: comment.id,
          likerId: userId,
        );
  }
}

class RecipeCommentPlaceholder extends StatelessWidget {
  const RecipeCommentPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            height: 44,
            width: 44,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 10,
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
