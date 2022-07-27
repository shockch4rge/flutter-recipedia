import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/common/snack.dart';
import 'package:flutter_recipedia/features/authentication/ui/login/login_screen.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../reset_password_screen.dart';
import 'reset_password_buttons.dart';

class SendEmailLinkForm extends StatefulWidget {
  const SendEmailLinkForm({Key? key}) : super(key: key);

  @override
  State<SendEmailLinkForm> createState() => _SendEmailLinkFormState();
}

class _SendEmailLinkFormState extends State<SendEmailLinkForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: "email",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
            decoration: InputDecoration(
              hoverColor: Theme.of(context).primaryColorDark,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              hintText: "johndoe@gmail.com",
              label: Text(
                "Email",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 58),
          SendEmailLinkButton(
            onPressed: () async {
              final authProvider = context.read<AuthProvider>();
              if (!_formKey.currentState!.saveAndValidate()) return;

              final email = _formKey.currentState!.value['email'];

              if (!(await authProvider.isUserAlreadyExists(email))) {
                Snack.bad(context, "Email is not registered!");
                return;
              }

              await authProvider.sendPasswordResetEmail(email);
              Snack.good(
                context,
                "An email has been sent to you.",
                SnackBarAction(
                  label: "Dismiss",
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              );

              await Navigator.of(context)
                  .pushNamed(ResetPasswordScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: "code",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: "The code is required!",
              ),
            ]),
            decoration: InputDecoration(
              hoverColor: Theme.of(context).primaryColorDark,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              hintText: "\$JohnDoe123",
              label: Text(
                "Code",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          FormBuilderTextField(
            name: "password",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(
                8,
                errorText: "Password must be at least 8 characters long",
              ),
            ]),
            decoration: InputDecoration(
              hoverColor: Theme.of(context).primaryColorDark,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              hintText: "\$JohnDoe123",
              label: Text(
                "New Password",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          ResetPasswordButton(
            onPressed: () async {
              if (!_formKey.currentState!.saveAndValidate()) return;

              final String code = _formKey.currentState!.value["code"];
              final String password = _formKey.currentState!.value["password"];

              try {
                await context
                    .read<AuthProvider>()
                    .confirmResetPassword(code, password);
                Snack.good(context, "Password reset! Please sign in again.");
                await Future.delayed(const Duration(seconds: 2));
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              } on FirebaseAuthException catch (err) {
                Snack.bad(context, err.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}
