import 'package:flutter/material.dart';
import 'package:ziya_user/services/global_search_service.dart';
import 'package:ziya_user/views/common/inline_search_bar.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import '../../constants/app_colors.dart';

class InlineSearchWidget extends StatefulWidget implements PreferredSizeWidget {
  final String searchHint;
  final Function(String) onSubmitQuery;

  const InlineSearchWidget({
    super.key,
    required this.searchHint,
    required this.onSubmitQuery,
  });

  @override
  State<InlineSearchWidget> createState() => _InlineSearchWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _InlineSearchWidgetState extends State<InlineSearchWidget> {
  bool isSearching = false;
  String searchQuery = '';

  final GlobalSearchService _searchService = GlobalSearchService();

  void _submitSearch() {
    if (searchQuery.trim().isEmpty) return;
    _searchService.add(searchQuery.trim());
    widget.onSubmitQuery(searchQuery.trim());
    setState(() {
      searchQuery = '';
      isSearching = false;
    });
  }

  void _toggleSearch(bool enable) {
    setState(() {
      isSearching = enable;
      if (!enable) searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final history = _searchService.history;

    return Column(
      children: [
        isSearching
            ? InlineSearchBar(
                query: searchQuery,
                onQueryChanged: (val) => setState(() => searchQuery = val),
                onSubmit: _submitSearch,
                onClose: () => _toggleSearch(false),
              )
            : TopNavigationBar(
                onSearchTap: () => _toggleSearch(true),
                searchHint: widget.searchHint,
              ),
        if (isSearching && history.isNotEmpty)
          Container(
            width: double.infinity,
            color: AppColors.white,
            constraints: const BoxConstraints(maxHeight: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Search History',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: history.length,
                    itemBuilder: (_, index) {
                      final item = history[index];
                      return ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            searchQuery = item;
                          });
                          _submitSearch();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
