import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String avatarUrl;
  final bool contain;
  const Avatar(
      {Key? key,
      required this.size,
      required this.avatarUrl,
      this.contain = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(avatarUrl),
          fit: contain ? BoxFit.contain : BoxFit.cover,
        ),
      ),
    );
  }
}
