import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdateAvatarActions extends StatelessWidget {
  final void Function() onCameraOptionPressed;
  final void Function() onGalleryOptionPressed;

  const UpdateAvatarActions({
    Key? key,
    required this.onCameraOptionPressed,
    required this.onGalleryOptionPressed,
  }) : super(key: key);

  static const shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 40,
            margin: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade400.withOpacity(0.7),
            ),
          ),
          Column(
            children: [
              ListTile(
                onTap: onCameraOptionPressed,
                title: Wrap(
                  spacing: 24,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(FontAwesomeIcons.camera),
                    Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              ListTile(
                onTap: onGalleryOptionPressed,
                title: Wrap(
                  spacing: 24,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(FontAwesomeIcons.images),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
