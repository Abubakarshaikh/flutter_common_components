import 'package:flutter/material.dart';

/// A [SearchDelegate] that filters [items] by case-insensitive substring.
///
/// Open with `showSearch(context: context, delegate: CommonSearchDelegate(...))`.
class CommonSearchDelegate extends SearchDelegate<String?> {
  CommonSearchDelegate({
    required this.items,
    this.resultBuilder,
    super.searchFieldLabel,
  });

  final List<String> items;

  /// Builds the results page; defaults to showing the query centered.
  final Widget Function(BuildContext context, String query)? resultBuilder;

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, null),
    icon: const BackButtonIcon(),
  );

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
      icon: const Icon(Icons.clear),
    ),
  ];

  @override
  Widget buildResults(BuildContext context) =>
      resultBuilder?.call(context, query) ??
      Center(child: Text(query, style: Theme.of(context).textTheme.titleSmall));

  @override
  Widget buildSuggestions(BuildContext context) {
    final input = query.toLowerCase();
    final suggestions = items
        .where((item) => item.toLowerCase().contains(input))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          title: Text(item),
          onTap: () {
            query = item;
            showResults(context);
          },
        );
      },
    );
  }
}
