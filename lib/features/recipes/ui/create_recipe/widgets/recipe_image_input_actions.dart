import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/app_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipeImageInputActions extends StatelessWidget {
  final void Function() onCameraOptionPressed;
  final void Function() onGalleryOptionPressed;

  const RecipeImageInputActions({
    Key? key,
    required this.onCameraOptionPressed,
    required this.onGalleryOptionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(actions: [
      AppBottomSheetAction(
        onPressed: onCameraOptionPressed,
        icon: const Icon(FontAwesomeIcons.camera),
        title: "Camera",
      ),
      AppBottomSheetAction(
        onPressed: onGalleryOptionPressed,
        icon: const Icon(FontAwesomeIcons.images),
        title: "Gallery",
      ),
    ]);
  }
}
