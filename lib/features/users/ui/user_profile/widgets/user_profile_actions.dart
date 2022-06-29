import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../personal_profile_settings/personal_profile_settings_screen.dart';

class UserProfileActions extends StatelessWidget {
  const UserProfileActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 40,
            margin: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade400.withOpacity(0.7),
            ),
          ),
          Column(
            children: [
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                  PersonalProfileSettingsScreen.routeName,
                ),
                title: Wrap(
                  spacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(FontAwesomeIcons.solidBell),
                    Text(
                      "Receive post notifications",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
