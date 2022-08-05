import 'package:flutter/material.dart';
import 'package:flutter_recipedia/common/keep_alive_stateful.dart';
import 'package:flutter_recipedia/features/search/app/search_provider.dart';
import 'package:flutter_recipedia/features/search/ui/search/recipe_search_tab.dart';
import 'package:flutter_recipedia/features/search/ui/search/user_search_tab.dart';
import 'package:provider/provider.dart';

import 'widgets/search_app_bar.dart';

class SearchScreen extends KeepAliveStateful {
  static const routeName = "/home/search";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  KeepAliveState createState() => _SearchScreenState();
}

class _SearchScreenState extends KeepAliveState
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);
  late final searchProvider = context.read<SearchProvider>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SearchAppBar(
        tabController: tabController,
        onTabTapped: (index) {
          searchProvider.setSearchTerm(
            index == 0 ? SearchTerm.user : SearchTerm.recipe,
          );
        },
        onSearch: (query) async {
          try {
            if (searchProvider.searchTerm == SearchTerm.user) {
              await searchProvider.searchForUsers(query);
              return;
            }

            if (searchProvider.searchTerm == SearchTerm.recipe) {
              await searchProvider.searchForRecipes(query);
              return;
            }
          } catch (e) {
            print("Could not find ${searchProvider.searchTerm}");
          }
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [UserSearchTab(), RecipeSearchTab()],
        ),
      ),
    );
  }
}
