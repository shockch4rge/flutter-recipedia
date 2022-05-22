import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String avatarUrl;
  const Avatar({Key? key, required this.size, required this.avatarUrl})
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
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
