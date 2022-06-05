import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';
import 'package:flutter_recipedia/widgets/common/avatar.dart';

import '../../models/user.dart';

class PostComment extends StatelessWidget {
  final void Function(User user) onReplyTap;
  final RecipeComment comment;

  const PostComment({Key? key, required this.onReplyTap, required this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 4, right: 6),
                child: Avatar(
                  size: 40,
                  avatarUrl: "assets/images/avatar_placeholder.png",
                ),
              ),
              SizedBox(
                width: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "johndoe123",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "I love this recipe! Highly recommend it. dwdwdwdwdwdwdwdwdwdw",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "1.2k likes",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          // TODO: amend mock user
                          onTap: () => onReplyTap(mockUser),
                          child: const Text(
                            "Reply",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          IconButton(
            onPressed: () {},
            splashRadius: 18,
            icon: const Icon(
              FeatherIcons.heart,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
