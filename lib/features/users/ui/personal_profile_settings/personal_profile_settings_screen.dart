import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/snack.dart';
import 'package:flutter_recipedia/features/authentication/ui/login/login_screen.dart';
import 'package:flutter_recipedia/features/users/ui/personal_profile_settings/widgets/delete_profile_dialog.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:provider/provider.dart';

import 'widgets/personal_profile_settings_app_bar.dart';
import 'widgets/personal_profile_settings_form.dart';

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
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
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
                    onConfirm: () async {
                      final authProvider = context.read<AuthProvider>();
                      final userRepo = context.read<UserRepository>();

                      await authProvider.deleteUser();
                      await userRepo.deleteUser(user.id);
                      Snack.good(context, "Profile deleted successfully.");
                      await Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
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
