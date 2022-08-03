import 'package:flutter/material.dart';

class CheckBoxListItem extends StatelessWidget {
  final String title;
  final bool checked;
  final void Function(bool checked) onChanged;

  const CheckBoxListItem({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.checked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      value: checked,
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onChanged: (value) => onChanged(value!),
      contentPadding: EdgeInsets.zero,
      activeColor: Theme.of(context).primaryColorDark,
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
    );
  }
}
