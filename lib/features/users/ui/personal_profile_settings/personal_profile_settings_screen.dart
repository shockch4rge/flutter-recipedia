import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/app/avatar_repository.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/widgets/delete_profile_dialog.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/widgets/update_avatar_actions.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'widgets/personal_profile_settings_app_bar.dart';

class PersonalProfileSettingsScreen extends StatefulWidget {
  static const routeName = "/home/profile/me/settings";

  const PersonalProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalProfileSettingsScreen> createState() =>
      _PersonalProfileSettingsScreenState();
}

class _PersonalProfileSettingsScreenState
    extends State<PersonalProfileSettingsScreen> {
  User get user => getArgs<User>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PersonalProfileSettingsAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            _AvatarImage(user: user),
            const SizedBox(height: 10),
            PersonalProfileSettingsForm(user: user),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<AuthProvider>().signOut();
                  Navigator.of(context).pop();
                },
                child: const Text("SIGN OUT"),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white,
                  onPrimary: Theme.of(context).primaryColor,
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => DeleteProfileDialog(
                    user: user,
                    onConfirm: () {},
                  ),
                ),
                child: const Text("DELETE PROFILE"),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white,
                  onPrimary: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarImage extends StatefulWidget {
  final User user;

  const _AvatarImage({Key? key, required this.user}) : super(key: key);

  @override
  State<_AvatarImage> createState() => _AvatarImageState();
}

class _AvatarImageState extends State<_AvatarImage> {
  final ImagePicker _imagePicker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();
  File? _uploadedAvatar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: widget.user.avatarUrl,
          imageBuilder: (context, image) {
            return ClipOval(
              child: Material(
                child: Ink.image(
                  width: 84,
                  height: 84,
                  image: _uploadedAvatar != null
                      ? FileImage(_uploadedAvatar!)
                      : image,
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(0.1),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      shape: UpdateAvatarActions.shape,
                      builder: (_) => UpdateAvatarActions(
                        onCameraOptionPressed: () async {
                          await _pickAvatar(ImageSource.camera);

                          if (_uploadedAvatar != null) {
                            context.read<AvatarRepository>().updateAvatar(
                                  userId: widget.user.id,
                                  file: _uploadedAvatar!,
                                );
                          }
                        },
                        onGalleryOptionPressed: () async {
                          await _pickAvatar(ImageSource.gallery);

                          if (_uploadedAvatar != null) {
                            context.read<AvatarRepository>().updateAvatar(
                                  userId: widget.user.id,
                                  file: _uploadedAvatar!,
                                );
                          }
                        },
                      ),
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          placeholder: (context, url) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        Positioned(
          bottom: -3,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: const Border.fromBorderSide(
                BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickAvatar(ImageSource source) async {
    final initial = await _imagePicker.pickImage(source: source);
    if (initial == null) return;

    final cropped = await _imageCropper.cropImage(
      sourcePath: File(initial.path).absolute.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          activeControlsWidgetColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Theme.of(context).primaryColorDark,
          toolbarTitle: "Crop Avatar",
        )
      ],
    );
    if (cropped == null) return;

    setState(() => _uploadedAvatar = File(cropped.path));
  }
}

class PersonalProfileSettingsForm extends StatefulWidget {
  final User user;

  const PersonalProfileSettingsForm({Key? key, required this.user})
      : super(key: key);

  @override
  State<PersonalProfileSettingsForm> createState() =>
      _PersonalProfileSettingsFormState();
}

class _PersonalProfileSettingsFormState
    extends State<PersonalProfileSettingsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _UsernameFormField(username: widget.user.username),
          _NameFormField(name: widget.user.name),
          _BioFormField(bio: widget.user.bio),
          const SizedBox(height: 40),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColorDark,
              ),
              child: Text("SAVE CHANGES"),
            ),
          )
        ],
      ),
    );
  }
}

class _UsernameFormField extends StatelessWidget {
  final String username;

  const _UsernameFormField({Key? key, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        validator: (value) {
          if (value! == username) {
            return "You can't have the same username as the previous one.";
          }

          return null;
        },
        initialValue: username,
        decoration: const InputDecoration(
          label: Text("Username"),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}

class _NameFormField extends StatelessWidget {
  final String name;

  const _NameFormField({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        validator: (value) {
          if (value! == name) {
            return "You can't have the same name as your previous one.";
          }

          return null;
        },
        initialValue: name,
        decoration: const InputDecoration(
          label: Text("Name"),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}

class _BioFormField extends StatelessWidget {
  final String bio;

  const _BioFormField({Key? key, required this.bio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 26, bottom: 8),
      child: TextFormField(
        validator: (value) {
          if (value! == bio) {
            return "You can't have the same biography as your previous one.";
          }
          return null;
        },
        initialValue: bio,
        decoration: const InputDecoration(
          label: Text("Bio"),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
          // contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        minLines: 2,
        maxLines: 5,
      ),
    );
  }
}
