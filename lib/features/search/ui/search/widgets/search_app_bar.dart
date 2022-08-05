import 'package:flutter/material.dart';
import 'package:flutter_recipedia/features/search/app/search_provider.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final void Function(int index) onTabTapped;
  final void Function(String query) onSearch;

  const SearchAppBar({
    Key? key,
    required this.tabController,
    required this.onTabTapped,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: kToolbarHeight + 80,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Text(
            "Search",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          const SizedBox(height: 12),
          SearchBar(
            searchTerm:
                context.watch<SearchProvider>().searchTerm == SearchTerm.user
                    ? "Users"
                    : "Recipes",
            onSearch: onSearch,
          ),
        ],
      ),
      bottom: TabBar(
        onTap: onTabTapped,
        controller: tabController,
        tabs: [
          Tab(
            child: Text(
              "Users",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Tab(
            child: Text(
              "Recipes",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160);
}

class SearchBar extends StatefulWidget {
  final String searchTerm;
  final void Function(String query) onSearch;

  const SearchBar({Key? key, required this.searchTerm, required this.onSearch})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.centerEnd,
      children: [
        TextField(
          controller: searchController,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          onSubmitted: (_) => widget.onSearch(searchController.text),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.black.withOpacity(0.1),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: "Search for ${widget.searchTerm.toLowerCase()}!",
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
        Positioned(
          top: -4,
          right: 0,
          child: Material(
            child: InkWell(
              onTap: () => widget.onSearch(searchController.text),
              child: Ink(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).primaryColorDark,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
