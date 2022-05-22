import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';

class CheckBoxListItem extends StatefulWidget {
  final String title;

  const CheckBoxListItem({Key? key, required this.title}) : super(key: key);

  @override
  State<CheckBoxListItem> createState() => _CheckBoxListItemState();
}

class _CheckBoxListItemState extends State<CheckBoxListItem> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: checked,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onChanged: (value) => setState(() {
        if (value != null) {
          checked = value;
        }
      }),
      contentPadding: EdgeInsets.zero,
      activeColor: App.primaryAccent,
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
    );
  }
}
