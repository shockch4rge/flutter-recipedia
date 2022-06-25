import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/app/avatar_provider.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/app/avatar_repository.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/widgets/delete_profile_dialog.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/widgets/update_avatar_actions.dart';
import 'package:flutter_recipedia/main.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
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
                  image: context.watch<AvatarProvider>().uploadedAvatar != null
                      ? FileImage(
                          context.read<AvatarProvider>().uploadedAvatar!)
                      : image,
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(0.1),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      shape: UpdateAvatarActions.shape,
                      builder: (_) => UpdateAvatarActions(
                        onCameraOptionPressed: () async {
                          final file = await _pickAvatar(ImageSource.camera);
                          context
                              .read<AvatarProvider>()
                              .setUploadedAvatar(file);
                        },
                        onGalleryOptionPressed: () async {
                          final file = await _pickAvatar(ImageSource.gallery);
                          context
                              .read<AvatarProvider>()
                              .setUploadedAvatar(file);
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

  Future<File?> _pickAvatar(ImageSource source) async {
    final initial = await _imagePicker.pickImage(source: source);
    if (initial == null) return null;

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
    if (cropped == null) return null;

    return File(cropped.path);
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
    extends State<PersonalProfileSettingsForm> with RouteAware {
  final _formKey = GlobalKey<FormState>();
  late final _usernameController = TextEditingController(text: username);
  late final _nameController = TextEditingController(text: name);
  late final _bioController = TextEditingController(text: bio);

  User get user => widget.user;
  String get username => widget.user.username;
  String get name => widget.user.name;
  String get bio => widget.user.bio;
  String get avatarUrl => widget.user.avatarUrl;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          _AvatarImage(user: user),
          _UsernameFormField(
              controller: _usernameController, username: username),
          _NameFormField(controller: _nameController, name: name),
          _BioFormField(controller: _bioController, bio: bio),
          const SizedBox(height: 40),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () async {
                String? newAvatarUrl;

                if (context.read<AvatarProvider>().uploadedAvatar != null) {
                  newAvatarUrl = await context
                      .read<AvatarRepository>()
                      .updateAvatar(
                        userId: user.id,
                        file: context.read<AvatarProvider>().uploadedAvatar!,
                      );
                }

                context.read<UserRepository>().updateUser(
                      user: widget.user,
                      username: _usernameController.text,
                      name: _nameController.text,
                      bio: _bioController.text,
                      avatarUrl: newAvatarUrl ?? avatarUrl,
                    );
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColorDark,
              ),
              child: const Text("SAVE CHANGES"),
            ),
          )
        ],
      ),
    );
  }

  @override
  void didPop() {
    context.read<AvatarProvider>().reset();
    super.didPop();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class _UsernameFormField extends StatelessWidget {
  final String username;
  final TextEditingController controller;

  const _UsernameFormField(
      {Key? key, required this.controller, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: _validator,
        // initialValue: username,
        decoration: const InputDecoration(
          label: Text("Username"),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if (value! == username) {
      return "You can't have the same username as the previous one.";
    }

    if (value.length <= 2) {
      return "Your name must be at least 3 characters long.";
    }

    return null;
  }
}

class _NameFormField extends StatelessWidget {
  final String name;
  final TextEditingController controller;

  const _NameFormField({Key? key, required this.controller, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: _validator,
        // initialValue: name,
        decoration: const InputDecoration(
          label: Text("Name"),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if (value! == name) {
      return "You can't have the same name as your previous one.";
    }
    return null;
  }
}

class _BioFormField extends StatelessWidget {
  final String bio;
  final TextEditingController controller;

  const _BioFormField({Key? key, required this.controller, required this.bio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 26, bottom: 8),
      child: TextFormField(
        controller: controller,
        validator: _validator,
        // initialValue: bio,
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
        maxLines: 6,
      ),
    );
  }

  String? _validator(String? value) {
    if (value! == bio) {
      return "You can't have the same biography as your previous one.";
    }
    return null;
  }
}
