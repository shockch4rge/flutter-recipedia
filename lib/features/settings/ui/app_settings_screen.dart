import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/switch_list_item.dart';

import 'widgets/app_settings_app_bar.dart';

// this screen is unimplemented at the moment as it deals with app preferences
class AppSettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppSettingsAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SwitchListItem(
            title: "Enable dark mode",
            onSwitch: (checked) async {},
            checked: false,
          ),
          const SizedBox(height: 6),
          SwitchListItem(
            title: "Enable push notifications",
            onSwitch: (checked) {},
            checked: false,
          ),
        ],
      ),
    );
  }
}
