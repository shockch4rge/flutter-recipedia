import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class PostContent extends StatelessWidget {
  final Recipe recipe;

  const PostContent({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Size.infinite.width,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 15),
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
        ),
        Container(
          width: Size.infinite.width,
          height: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/post_placeholder.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text(
                "Truffle Spaghetti",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.left,
              )
            ],
          ),
        )
      ],
    );
  }
}
