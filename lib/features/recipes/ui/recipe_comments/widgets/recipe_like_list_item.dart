import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/avatar.dart';
import 'package:flutter_recipedia/models/user.dart';

class RecipeLikeListItem extends StatelessWidget {
  final User liker;

  const RecipeLikeListItem({Key? key, required this.liker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Avatar(
              size: 40,
              avatarUrl: liker.avatarUrl,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  liker.username,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 4),
                Text(
                  liker.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          // ElevatedButton(
          //   onPressed: () => showDialog(
          //     context: context,
          //     builder: (_) {
          //       return RemoveFollowerDialog(
          //         liker: liker,
          //         onConfirm: () {
          //           print("onConfirm remove");
          //         },
          //       );
          //     },
          //   ),
          //   child: const Text(
          //     "Remove",
          //     style: TextStyle(
          //       fontSize: 12,
          //     ),
          //   ),
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.white,
          //     onPrimary: Theme.of(context).primaryColor,
          //     elevation: 0,
          //     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //       side: BorderSide(
          //         color: Theme.of(context).primaryColorDark,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
