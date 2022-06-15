import 'package:flutter/material.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
      activeColor: Theme.of(context).primaryColorDark,
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
    );
  }
}
