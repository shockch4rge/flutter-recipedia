import 'package:flutter/material.dart';

import './widgets/reset_password_forms.dart';

class SendEmailLinkScreen extends StatefulWidget {
  static const String routeName = "/send-email-link";

  const SendEmailLinkScreen({Key? key}) : super(key: key);

  @override
  State<SendEmailLinkScreen> createState() => _SendEmailLinkScreenState();
}

class _SendEmailLinkScreenState extends State<SendEmailLinkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                icon: Icon(Icons.arrow_back_ios, size: 16),
                label: Text("Back to login"),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 140, left: 30, right: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      "Reset your password.",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                const SizedBox(height: 58),
                Text(
                  "Enter your e-mail so we can send a password reset link. We'll sort things out from there!",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 58),
                const SizedBox(child: SendEmailLinkForm()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
