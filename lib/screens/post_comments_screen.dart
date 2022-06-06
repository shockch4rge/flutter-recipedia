import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/providers/comment_provider.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:flutter_recipedia/widgets/appbars/post_comments_app_bar.dart';
import 'package:flutter_recipedia/widgets/post/post_comment.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class PostCommentsScreen extends StatefulWidget {
  static const routeName = "/recipe/comments";

  const PostCommentsScreen({Key? key}) : super(key: key);

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen>
    with RouteAware {
  final FocusNode _commentInputFocus = FocusNode();
  get comments => getArgs<List<RecipeComment>>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PostCommentsAppBar(),
      body: Stack(
        children: [
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              return PostComment(
                comment: comments[0],
                onReplyTap: (commentAuthor) async {
                  context.read<CommentProvider>().setReplyTarget(commentAuthor);
                  // un-focus in case we focused it before
                  _commentInputFocus.unfocus();
                  // allow time for widget to re-render
                  await Future.delayed(const Duration(milliseconds: 200));
                  _commentInputFocus.requestFocus();
                },
              );
            }),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                if (context.watch<CommentProvider>().replyTarget != null)
                  Container(
                    height: 46,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Replying to ${context.watch<CommentProvider>().replyTarget!.username}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<CommentProvider>()
                                .setReplyTarget(null);
                            _commentInputFocus.unfocus();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.grey.shade400,
                          ),
                          splashColor: Colors.transparent,
                        )
                      ],
                    ),
                  ),
                Container(
                  height: 72,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        focusNode: _commentInputFocus,
                        cursorColor: Colors.grey,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          hintText: "Add a thought...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          constraints: const BoxConstraints(maxWidth: 290),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.05),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // send TextField content
                        },
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          primary: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _commentInputFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void didPop() {
    context.read<CommentProvider>().setReplyTarget(null);
  }
}
