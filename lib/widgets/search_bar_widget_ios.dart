import 'package:document_management_main/utils/file_data_service_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/create_fileStructure.dart';
import 'search_bar_widget.dart';

class FileSearchScreen extends StatefulWidget {
  final Widget child; // Named parameter for customization
  final Function setFilteredData;

  const FileSearchScreen(
      {super.key, required this.child, required this.setFilteredData});

  @override
  State<FileSearchScreen> createState() {
    return _FileSearchScreenState();
  }

}

class _FileSearchScreenState extends State<FileSearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<FileItemNew> _searchResults = [];
  List<String> files = [
    "Document.pdf",
    "Notes.txt",
    "Image.png",
    "Report.docx"
  ];
  List<String> filteredFiles = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    filteredFiles = List.from(files);
  }

  /// The same search logic used previously.
  List<FileItemNew> _searchAllItems(String query, List<FileItemNew> items) {
    final results = <FileItemNew>[];
    for (var item in items) {
      // If the item's name contains the query (case-insensitive), add it to results.
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        results.add(item);
      }
      // If this item has children, search them too.
      if (item.children != null && item.children!.isNotEmpty) {
        results.addAll(_searchAllItems(query, item.children!));
      }
    }
    return results;
  }

  void searchFiles(String query) {
    final results = _searchAllItems(query, allItems);
    setState(() {
      _searchResults = results;
      // widget.setFilteredData(results);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints(maxHeight: 40),
                child: CupertinoSearchTextField(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => SearchPage(
                          onSearch: _searchAllItems,
                        ),
                      ),
                    );
                  },
                  controller: searchController,
                  onChanged: searchFiles,
                  placeholder: "Search documents",
                  backgroundColor: CupertinoColors.systemGrey5,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
            Expanded(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
