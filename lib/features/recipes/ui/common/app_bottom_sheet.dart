import 'package:flutter/material.dart';

// generic bottom sheet that is already configured to the app's theme
class AppBottomSheet extends StatelessWidget {
  final List<AppBottomSheetAction> actions;
  const AppBottomSheet({Key? key, required this.actions}) : super(key: key);

  static const defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
    ),
  );

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
              for (final action in actions) ...[
                ListTile(
                  onTap: action.onPressed,
                  title: Wrap(
                    spacing: 24,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      action.icon,
                      Text(
                        action.title,
                        style: const TextStyle(
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
              ]
            ],
          )
        ],
      ),
    );
  }
}

// describes the action for each tile in the bottom sheet
class AppBottomSheetAction {
  final Icon icon;
  final String title;
  final VoidCallback onPressed;

  const AppBottomSheetAction({
    required this.onPressed,
    required this.icon,
    required this.title,
  });
}
