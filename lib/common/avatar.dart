import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// this is a generic widget that displays a circular network image that caches itself into the device's memory.
// it saves on loading images that have already been loaded before.
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
    return CachedNetworkImage(
      imageUrl: avatarUrl,
      placeholder: (context, url) => Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(2),
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey.shade200,
          color: Colors.grey.shade300,
        ),
      ),
      imageBuilder: (context, provider) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: provider,
              fit: contain ? BoxFit.contain : BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
