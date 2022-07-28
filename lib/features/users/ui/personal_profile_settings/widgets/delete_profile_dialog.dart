import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DeleteProfileDialog extends StatefulWidget {
  final User user;
  final void Function(String email, String password) onConfirm;

  const DeleteProfileDialog(
      {Key? key, required this.user, required this.onConfirm})
      : super(key: key);

  @override
  State<DeleteProfileDialog> createState() => _DeleteProfileDialogState();
}

class _DeleteProfileDialogState extends State<DeleteProfileDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Enter your email and password to delete your profile.",
      ),
      content: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Wrap(
            runSpacing: 20,
            children: [
              FormBuilderTextField(
                name: "email",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                decoration: const InputDecoration(
                  label: Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              FormBuilderTextField(
                name: "password",
                obscureText: !showPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: "Password must be at least 8 characters long.",
                  ),
                ]),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => showPassword = !showPassword);
                    },
                    color: showPassword ? Colors.black : Colors.grey.shade400,
                    splashRadius: 20,
                    icon: showPassword
                        ? Icon(
                            FontAwesomeIcons.eye,
                            size: 16,
                            color: Theme.of(context).primaryColorDark,
                          )
                        : const Icon(
                            FontAwesomeIcons.eyeSlash,
                            size: 16,
                          ),
                  ),
                  label: Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel"),
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
        ),
        TextButton(
          onPressed: () {
            if (!_formKey.currentState!.saveAndValidate()) return;

            final String email = _formKey.currentState!.value['email'];
            final String password = _formKey.currentState!.value['password'];

            widget.onConfirm(email, password);
            Navigator.of(context).pop();
          },
          child: const Text("Delete"),
          style: TextButton.styleFrom(
            primary: Colors.red,
          ),
        )
      ],
    );
  }
}
