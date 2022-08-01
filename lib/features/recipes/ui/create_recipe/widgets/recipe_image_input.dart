import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/recipes/app/create_recipe_provider.dart';
import 'package:flutter_recipedia/features/recipes/ui/common/app_bottom_sheet.dart';
import 'package:flutter_recipedia/features/recipes/ui/create_recipe/widgets/recipe_image_input_actions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RecipeImageInput extends StatefulWidget {
  const RecipeImageInput({Key? key}) : super(key: key);

  @override
  State<RecipeImageInput> createState() => _RecipeImageInputState();
}

class _RecipeImageInputState extends State<RecipeImageInput> {
  final _imagePicker = ImagePicker();
  final _imageCropper = ImageCropper();
  double get horizontalPadding => 48;

  @override
  Widget build(BuildContext context) {
    final File? currentImage =
        context.watch<CreateRecipeProvider>().uploadedImage;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width - horizontalPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey.shade200,
        image: currentImage != null
            ? DecorationImage(
                image: FileImage(currentImage),
                fit: BoxFit.cover,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: currentImage == null
          ? ElevatedButton.icon(
              onPressed: () => showModalBottomSheet(
                context: context,
                shape: AppBottomSheet.defaultShape,
                builder: (_) => RecipeImageInputActions(
                  onCameraOptionPressed: () => _pickImage(ImageSource.camera),
                  onGalleryOptionPressed: () => _pickImage(ImageSource.gallery),
                ),
              ),
              icon: const Icon(FontAwesomeIcons.plus),
              label: const Text("Select an image!"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.white,
                onPrimary: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          : null,
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final initial = await _imagePicker.pickImage(source: source);
    if (initial == null) return;

    final cropped = await _imageCropper.cropImage(
      sourcePath: File(initial.path).absolute.path,
      uiSettings: [
        AndroidUiSettings(
          activeControlsWidgetColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Theme.of(context).primaryColorDark,
          toolbarTitle: "Crop Image",
        )
      ],
    );

    if (cropped == null) return;
    context.read<CreateRecipeProvider>().setUploadedImage(File(cropped.path));
  }
}
