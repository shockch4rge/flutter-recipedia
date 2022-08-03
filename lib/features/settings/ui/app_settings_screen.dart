import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/switch_list_item.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'widgets/app_settings_app_bar.dart';

class AppSettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppSettingsAppBar(),
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box("settings").listenable(),
        builder: (context, box, widget) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 6),
              SwitchListItem(
                title: "Enable notifications",
                onSwitch: (checked) {
                  box.put("enableNotifications", checked);
                },
                checked: box.get("enableNotifications", defaultValue: false),
              ),
              ElevatedButton(
                onPressed: () async {
                  context.read<AuthProvider>().signOut();
                },
                child: Text("Hello"),
              )
            ],
          );
        },
      ),
    );
  }
}
