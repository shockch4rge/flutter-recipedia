import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

import '../../models/recipe.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Size.infinite.width,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/post_placeholder.jpg"),
                  ),
                ),
              ),
              Text(
                "lisahannigan",
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Material(
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(99),
              child:
                  Ink(color: Colors.white, child: const Icon(Icons.more_horiz)),
            ),
          )
        ],
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  const PostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Size.infinite.width,
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

class PostContent extends StatelessWidget {
  final Recipe recipe;

  const PostContent({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PostHeader(),
        const PostImage(),
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
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          elevation: MaterialStateProperty.all(0),
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
