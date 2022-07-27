import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/common/snack.dart';
import 'package:flutter_recipedia/features/misc/home_screen.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/user_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import 'signup_buttons.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autoFocusOnValidationFailure: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          FormBuilderTextField(
            name: "fullName",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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
              hintText: "John Doe",
              label: Text(
                "Full Name",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FormBuilderTextField(
            name: "username",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(
                3,
                errorText: "Username must have at least 3 characters.",
              ),
              FormBuilderValidators.maxLength(
                20,
                errorText: "Username must not have more than 20 characters.",
              ),
            ]),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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
              hintText: "JohnDoe123",
              label: Text(
                "Username",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FormBuilderTextField(
            name: "email",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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
          const SizedBox(height: 20),
          FormBuilderTextField(
            name: "password",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(
                8,
                errorText: "Password must be at least 8 characters long.",
              ),
            ]),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            obscureText: showPassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => setState(() => showPassword = !showPassword),
                color: showPassword ? Colors.black : Colors.grey.shade400,
                splashRadius: 20,
                icon: showPassword
                    ? const Icon(
                        FontAwesomeIcons.eyeSlash,
                        size: 18,
                      )
                    : Icon(
                        FontAwesomeIcons.eye,
                        size: 18,
                        color: Theme.of(context).primaryColorDark,
                      ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              hoverColor: Theme.of(context).primaryColorDark,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              label: Text(
                "Password",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline3?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              SignUpButton(
                onPressed: () async {
                  if (!_formKey.currentState!.saveAndValidate()) return;
                  final authProvider = context.read<AuthProvider>();
                  final userRepo = context.read<UserRepository>();

                  final fullName = _formKey.currentState!.value['fullName'];
                  final username = _formKey.currentState!.value['username'];
                  final email = _formKey.currentState!.value['email'];
                  final password = _formKey.currentState!.value['password'];

                  if (await authProvider.isUserAlreadyExists(email)) {
                    Snack.bad(
                      context,
                      "User is already registered with that email!",
                    );
                    return;
                  }

                  final credentials = await authProvider.signUp(
                    email: email,
                    password: password,
                  );
                  final user = await userRepo.createUser(
                    uid: credentials.user!.uid,
                    name: fullName,
                    username: username,
                  );
                  await authProvider.signIn(
                    email: email,
                    password: password,
                  );
                  authProvider.setCurrentUser(user);
                  Snack.good(context, "Welcome to recipedia, $username!");
                  await Navigator.pushReplacementNamed(
                    context,
                    HomeScreen.routeName,
                  );
                },
              ),
              const SizedBox(height: 10),
              GoogleSignUpButton(
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
