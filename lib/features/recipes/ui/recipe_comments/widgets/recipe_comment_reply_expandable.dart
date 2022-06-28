import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/shorten_number.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../app/recipe_comment_reply_repository.dart';

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
  late final comment = widget.comment;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context
          .read<RecipeCommentReplyRepository>()
          .getAllByCommentId(comment.id),
      builder: (context, snap) {
        if (snap.waiting) {
          return Container();
        }

        final replies = snap.data as List<RecipeCommentReply>;

        if (replies.isEmpty) {
          return Container();
        }

        return ExpandablePanel(
          header: Text(
            "View ${shortenNumber(replies.length)} replies",
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryColor,
            ),
          ),
          collapsed: Container(),
          expanded: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: replies.map((reply) {
                return FutureBuilder(
                  future: context
                      .read<UserRepository>()
                      .getUserById(reply.authorId),
                  builder: (context, snap) {
                    if (snap.waiting) return Container();

                    final author = snap.data as User;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child:
                                Avatar(size: 28, avatarUrl: author.avatarUrl),
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                reply.content,
                                style: const TextStyle(fontSize: 11),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${shortenNumber(reply.likes.length)} likes",
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              if (reply.likes.contains(author.id)) {
                                context
                                    .read<RecipeCommentReplyRepository>()
                                    .removeLike(
                                      replyId: reply.id,
                                      likerId: author.id,
                                    );
                                return;
                              }

                              context
                                  .read<RecipeCommentReplyRepository>()
                                  .addLike(
                                    replyId: reply.id,
                                    likerId: author.id,
                                  );
                            },
                            splashRadius: 18,
                            icon: Icon(
                              reply.likes.contains(author.id)
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              size: 16,
                              color: reply.likes.contains(author.id)
                                  ? Theme.of(context).primaryColor
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          ),
          theme: ExpandableThemeData(
            tapHeaderToExpand: true,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            useInkWell: false,
            iconColor: Theme.of(context).primaryColor,
            iconPadding: const EdgeInsets.only(right: 120),
          ),
        );
      },
    );
  }
}
