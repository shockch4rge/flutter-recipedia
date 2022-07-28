import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/common/snack.dart';
import 'package:flutter_recipedia/features/authentication/ui/reset_password/send_email_link_screen.dart';
import 'package:flutter_recipedia/features/authentication/ui/signup/signup_screen.dart';
import 'package:flutter_recipedia/features/misc/home_screen.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import 'login_buttons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool showPassword = false;
  bool disableSignInButton = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: "email",
            // controller: _emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
            decoration: InputDecoration(
              hoverColor: Theme.of(context).primaryColorDark,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(7),
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
          const SizedBox(height: 20),
          Column(
            children: [
              FormBuilderTextField(
                name: "password",
                obscureText: !showPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: "Password must be at least 8 characters long.",
                  ),
                ]),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => showPassword = !showPassword),
                    color: showPassword ? Colors.black : Colors.grey.shade400,
                    splashRadius: 20,
                    icon: showPassword
                        ? Icon(
                            FontAwesomeIcons.eye,
                            size: 18,
                            color: Theme.of(context).primaryColorDark,
                          )
                        : Icon(
                            FontAwesomeIcons.eyeSlash,
                            size: 18,
                          ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  label: Text(
                    "Password",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline3?.color,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Size.infinite.width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text("Forgot password?"),
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => Navigator.of(context).pushNamed(
                      SendEmailLinkScreen.routeName,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              Column(
                children: [
                  SignInButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.saveAndValidate()) {
                        Snack.bad(
                          context,
                          "Invalid form submitted.",
                          SnackBarAction(
                            label: "Dismiss",
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        );
                        return;
                      }

                      final authProvider = context.read<AuthProvider>();
                      final userRepo = context.read<UserRepository>();

                      final String email =
                          _formKey.currentState!.value["email"];
                      final String password =
                          _formKey.currentState!.value["password"];

                      try {
                        final credentials = await authProvider.signIn(
                          email: email,
                          password: password,
                        );
                        final user =
                            await userRepo.getUserByUid(credentials.user!.uid);
                        authProvider.setCurrentUser(user);
                      } on auth.FirebaseAuthException catch (e) {
                        Snack.bad(
                          context,
                          "Incorrect email or password",
                          SnackBarAction(
                            label: "Dismiss",
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        );
                        return;
                      }

                      Snack.good(context, "Welcome back!");
                      await Navigator.of(context).pushReplacementNamed(
                        HomeScreen.routeName,
                      );
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width, height: 8),
                ],
              ),
              GoogleSignInButton(
                onPressed: () async {
                  final authProvider = context.read<AuthProvider>();
                  final email = _formKey.currentState!.value["email"];

                  if (await authProvider.isUserAlreadyExists(email)) {
                    Snack.bad(
                      context,
                      "That email is already registered!.",
                      SnackBarAction(
                        label: "Dismiss",
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    return;
                  }
                  await authProvider.signInGoogle();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextButton(
                  child: const Text("Don't have an account?"),
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SignUpScreen.routeName),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
