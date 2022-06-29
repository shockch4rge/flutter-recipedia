import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/keep_alive_stateful.dart';
import 'package:flutter_recipedia/main.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/providers/comment_provider.dart';
import 'package:flutter_recipedia/utils/extensions/async_helper.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';
import 'package:provider/provider.dart';

import './widgets/recipe_comment.dart' as widgets;
import '../../app/recipe_comment_reply_repository.dart';
import '../../app/recipe_comment_repository.dart';
import 'widgets/recipe_comments_app_bar.dart';

class RecipeCommentsScreen extends KeepAliveStateful {
  static const routeName = "/recipe/comments";

  const RecipeCommentsScreen({Key? key}) : super(key: key);

  @override
  State<RecipeCommentsScreen> createState() => _RecipeCommentsScreenState();
}

class _RecipeCommentsScreenState extends State<RecipeCommentsScreen>
    with RouteAware {
  // a controller to manipulate the scroll position of the list
  final _scrollController = ScrollController();
  // this allows us to focus on an attached text field
  final FocusNode _commentInputFocus = FocusNode();
  // controllers to manage text field state
  final _commentInputController = TextEditingController();
  DocumentReference get recipeId => getArgs<DocumentReference>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeCommentsAppBar(
        // scroll to the top of the screen when the app bar title is tapped
        onTitleTapped: () => _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: context
                .read<RecipeCommentRepository>()
                .getAllByRecipeId(recipeId),
            builder: (context, snap) {
              if (snap.waiting) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const widgets.RecipeCommentPlaceholder();
                  },
                );
              }
              final comments = snap.data as List<RecipeComment>;

              if (comments.isEmpty) {
                return const Center(
                  child: Text("Be the first to comment on this recipe!"),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: ((context, index) {
                  return widgets.RecipeComment(
                    comment: comments[index],
                    onReply: (commentAuthor) async {
                      context.read<CommentProvider>().setReplyTarget(
                            user: commentAuthor,
                            comment: comments[index],
                          );
                      // un-focus in case we focused it before
                      _commentInputFocus.unfocus();
                      // allow time for widget to re-render
                      await Future.delayed(const Duration(milliseconds: 200));
                      // request focus of the field when we press the button
                      _commentInputFocus.requestFocus();
                    },
                  );
                }),
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                if (context.watch<CommentProvider>().targetUser != null)
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
                          "Replying to ${context.watch<CommentProvider>().targetUser!.username}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<CommentProvider>().reset();
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
                        controller: _commentInputController,
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
                          // if we have a target user, we're replying to someone
                          if (context.read<CommentProvider>().hasTarget) {
                            // add a reply to the comment through the repo
                            context
                                .read<RecipeCommentReplyRepository>()
                                .addReply(
                                  recipeId: recipeId,
                                  authorId: mockMeId,
                                  // get the target comment
                                  commentId: context
                                      .read<CommentProvider>()
                                      .targetComment!
                                      .id,
                                  content: _commentInputController.text,
                                );
                            return;
                          }

                          // otherwise, we add a regular comment to the recipe
                          context.read<RecipeCommentRepository>().addComment(
                                recipeId: recipeId,
                                authorId: mockMeId,
                                content: _commentInputController.text,
                              );
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
  void didPop() {
    context.read<CommentProvider>().reset();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _commentInputController.dispose();
    _commentInputFocus.dispose();
    super.dispose();
  }
}
