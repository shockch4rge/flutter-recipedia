import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/features/recipes/app/recipe_comment_repository.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_comments/recipe_comment_likes_screen.dart';
import 'package:flutter_recipedia/features/recipes/ui/recipe_comments/widgets/recipe_comment_reply_expandable.dart';
import 'package:flutter_recipedia/models/recipe.dart' as model;
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/shorten_number.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../models/user.dart';

class RecipeComment extends StatefulWidget {
  final model.RecipeComment comment;
  final void Function(User author) onReply;

  const RecipeComment({Key? key, required this.onReply, required this.comment})
      : super(key: key);

  @override
  State<RecipeComment> createState() => _RecipeCommentState();
}

class _RecipeCommentState extends State<RecipeComment> {
  late final currentUser = context.read<AuthProvider>().user!;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          context.read<UserRepository>().getUserById(widget.comment.authorId),
      builder: (context, snap) {
        if (snap.waiting) {
          return Container();
        }

        final author = snap.data as User;

        return Column(
          children: [
            Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                closeThreshold: 0.1,
                extentRatio: 0.3,
                children: [
                  SlidableAction(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    onPressed: (_) => widget.onReply(author),
                    icon: CupertinoIcons.arrow_turn_up_left,
                  ),
                  if (author.id == currentUser.id)
                    SlidableAction(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      onPressed: (_) async {
                        await context
                            .read<RecipeCommentRepository>()
                            .deleteComment(widget.comment.id);
                      },
                      icon: CupertinoIcons.delete_simple,
                    ),
                ],
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                            widget.comment.content,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          RecipeCommentReplyExpandable(comment: widget.comment),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                  RecipeCommentLikesScreen.routeName,
                                  arguments: widget.comment.likes,
                                ),
                                child: Text(
                                  "${shortenNumber(widget.comment.likes.length)} likes",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => widget.onReply(author),
                                child: const Text(
                                  "Reply",
                                  style: TextStyle(
                                    fontSize: 14,
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
                          widget.comment.likes.contains(author.id)
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          size: 18,
                          color: widget.comment.likes.contains(author.id)
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _toggleLike(
      BuildContext context, DocumentReference userId) async {
    if (widget.comment.likes.contains(userId)) {
      await context.read<RecipeCommentRepository>().removeLike(
            commentId: widget.comment.id,
            likerId: userId,
          );
      return;
    }

    context.read<RecipeCommentRepository>().addLike(
          commentId: widget.comment.id,
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
