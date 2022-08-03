import 'package:flutter/material.dart';

class SwitchListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool checked;
  final void Function(bool checked) onSwitch;

  const SwitchListItem({
    Key? key,
    required this.title,
    required this.onSwitch,
    required this.checked,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      value: checked,
      onChanged: (value) => onSwitch(value),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      activeColor: Theme.of(context).primaryColorDark,
    );
  }
}
