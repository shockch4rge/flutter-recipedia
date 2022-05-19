import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';
import 'package:flutter_recipedia/widgets/post/post_options.dart';

import '../../models/recipe.dart';

class UserHeadline extends StatelessWidget {
  const UserHeadline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {},
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          icon: CachedNetworkImage(
            imageUrl: "flutter-recipedia.appspot.com/lisapfp2.png",
            imageBuilder: (context, imageProvider) => Container(
              width: 36,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
          label: Text("lisahannigan",
              style: Theme.of(context).textTheme.headline4),
        )
      ],
    );
  }
}

class UserHeadlineMock extends StatelessWidget {
  const UserHeadlineMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero, splashFactory: NoSplash.splashFactory),
      icon: Container(
        width: 36,
        margin: const EdgeInsets.only(right: 8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/images/post_placeholder.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      label: Text("lisahannigan", style: Theme.of(context).textTheme.headline4),
    );
  }
}

class PostHeader extends StatelessWidget {
  const PostHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          UserHeadlineMock(),
          PostOptions(),
        ],
      ),
    );
  }
}

class PostImageMock extends StatelessWidget {
  const PostImageMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/post_placeholder.jpg"),
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
        const PostHeader(),
        const PostImageMock(),
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
                        SizedBox(
                          width: 55,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            onPressed: () {},
                            icon: App.heartOutlinedIcon,
                            label: const Text(
                              "14",
                              style: TextStyle(color: App.primaryAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero)),
                            onPressed: () {},
                            icon: App.chatBubbleIcon,
                            label: const Text(
                              "3",
                              style: TextStyle(color: App.primaryAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero)),
                            onPressed: () {},
                            child: App.shareIcon,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed("/view-recipe"),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [App.primaryAccent, App.primaryColor]),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            constraints: const BoxConstraints(
                              minWidth: 88.0,
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
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Truffle Spaghetti Aglio e Olio Carbonara",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "lisahannigan:",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "I was planning to make a beef stew for tonight, but I got lazy midway and decided to whip up this quick carbonara instead! Quick and easy recipe (with no dumb cream)!",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
