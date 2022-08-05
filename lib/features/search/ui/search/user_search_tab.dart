import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/search/app/search_provider.dart';
import 'package:provider/provider.dart';

import './widgets/user_search_result.dart';

class UserSearchTab extends StatefulWidget {
  const UserSearchTab({Key? key}) : super(key: key);

  @override
  State<UserSearchTab> createState() => _UserSearchTabState();
}

class _UserSearchTabState extends State<UserSearchTab> {
  @override
  Widget build(BuildContext context) {
    final isSearching = context.watch<SearchProvider>().isSearchingUsers;
    final users = context.watch<SearchProvider>().users;

    if (isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (users.isEmpty) {
      return const Center(
        child: Text("There are no users to display!"),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return UserSearchResult(user: users[index]);
      },
      separatorBuilder: (context, index) => const Divider(height: 0),
      itemCount: users.length,
    );
  }
}
