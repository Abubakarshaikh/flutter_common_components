import 'package:flutter_common_components/src/app_text.dart';
import 'package:flutter_common_components/src/utils/icons_utils.dart';
import 'package:flutter/material.dart';

class CommonSearchBar extends SearchDelegate<String?> {
  List<String> searchResultList = <String>[
    'Brzail',
    'China',
    'India',
    'Russia',
    'Pakistan',
    'England',
    'Dubai',
  ];
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(IconUtils.arrowBack),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(IconUtils.clear),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: AppText.titleSmall(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions =
        searchResultList.where((String searchResult) {
      final String result = searchResult.toLowerCase();
      final String input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        final String item = suggestions.elementAt(index);
        return ListTile(
          onTap: () {
            query = item;
          },
          title: Text(item),
        );
      },
    );
  }
}
