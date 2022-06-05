import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/screens/post_comments_screen.dart';
import 'package:flutter_recipedia/screens/user_profile_screen.dart';
import 'package:flutter_recipedia/widgets/common/avatar.dart';
import 'package:flutter_recipedia/widgets/post/post_buttons.dart';
import 'package:flutter_recipedia/widgets/post/post_options_popup_menu.dart';

import '../../models/recipe.dart';
import '../../screens/view_recipe_screen.dart';

class PostHeader extends StatelessWidget {
  final Recipe recipe;
  const PostHeader({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {},
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          icon: CachedNetworkImage(
            imageUrl:
                "https://firebasestorage.googleapis.com/v0/b/flutter-recipedia.appspot.com/o/lisapfp2.png?alt=media&token=ba5642dd-f3c4-4a04-b7b4-1911dd193634",
            imageBuilder: (context, imageProvider) =>
                Avatar(size: 36, avatarUrl: recipe.imageUrl),
            placeholder: (context, url) => Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 15),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.grey.shade200,
                color: Colors.grey.shade300,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          label: Text(recipe.author.username,
              style: Theme.of(context).textTheme.headline4),
        )
      ],
    );
  }
}

class PostHeaderMock extends StatelessWidget {
  final Recipe recipe;
  const PostHeaderMock({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(
              context,
              UserProfileScreen.routeName,
              arguments: recipe.author,
            ),
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory),
            icon: Avatar(
              size: 36,
              avatarUrl: recipe.author.avatarUrl,
            ),
            label: Text(recipe.author.username,
                style: Theme.of(context).textTheme.subtitle1),
          ),
          PostOptionsPopupMenu(
            onSaveTapped: () {},
            onShareTapped: () {},
          ),
        ],
      ),
    );
  }
}

class PostImageMock extends StatelessWidget {
  final String imageUrl;
  const PostImageMock({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  const PostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "flutter-recipedia.appspot.com/post_placeholder.jpg",
      imageBuilder: (context, imageProvider) => Container(
        height: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey.shade200,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}

class PostContent extends StatelessWidget {
  final Recipe recipe;

  const PostContent({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostHeaderMock(recipe: recipe),
        PostImageMock(imageUrl: recipe.imageUrl),
        Container(
          padding: const EdgeInsets.only(left: 22, right: 22, bottom: 30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LikeButton(
                          onPressed: () {},
                        ),
                        CommentButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              PostCommentsScreen.routeName,
                              arguments: recipe.comments,
                            );
                          },
                        ),
                        ShareButton(
                          onPressed: () {},
                        )
                      ],
                    ),
                    ViewRecipeButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                        ViewRecipeScreen.routeName,
                        arguments: recipe,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDescription(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.title,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 14),
        Text(
          "${recipe.author.username}:",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        const SizedBox(height: 8),
        Text(
          recipe.description,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
