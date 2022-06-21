import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/widgets/confirm_delete_profile_dialog.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
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
            Avatar(
              size: 84,
              avatarUrl: user.avatarUrl,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text(
                "Change profile photo",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
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
                  builder: (_) => ConfirmDeleteProfileDialog(
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
          TextFormField(
            validator: (value) {
              if (value! == widget.user.username) {
                return "You can't have the same username as the previous one.";
              }

              return null;
            },
            initialValue: widget.user.username,
            decoration: const InputDecoration(
              label: Text("Username"),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value! == widget.user.name) {
                return "You can't have the same name as the previous one.";
              }

              return null;
            },
            initialValue: widget.user.name,
            decoration: const InputDecoration(
              label: Text("Name"),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
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
