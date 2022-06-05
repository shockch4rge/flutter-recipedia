import 'package:flutter/material.dart';
import 'package:flutter_recipedia/widgets/appbars/app_settings_app_bar.dart';
import 'package:flutter_recipedia/widgets/common/switch_list_item.dart';

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
