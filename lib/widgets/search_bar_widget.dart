// import 'package:flutter/material.dart';
// import 'package:document_management_main/data/file_data.dart';

// import '../data/create_fileStructure.dart';
// import '../files_viewer/image_viewer_page.dart';
// import '../files_viewer/pdf_viewer_page.dart';
// import '../files_viewer/text_viewer_page.dart';
// import 'folder_screen_widget.dart';

// class SearchBarWidget extends StatefulWidget {
//   const SearchBarWidget({super.key});

//   @override
//   State<SearchBarWidget> createState() {
//     return _SearchBarWidgetState();
//   }
// }

// class _SearchBarWidgetState extends State<SearchBarWidget> {

//   late SearchController _searchController;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = SearchController();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }


//   List<FileItemNew> _searchAllItems(String query, List<FileItemNew> items) {
//     final results = <FileItemNew>[];
//     for (var item in items) {
//       // If the item's name contains the query (case-insensitive), add it to results.
//       if (item.name.toLowerCase().contains(query.toLowerCase())) {
//         results.add(item);
//       }
//       // If this item has children, search them too.
//       if (item.children != null && item.children!.isNotEmpty) {
//         results.addAll(_searchAllItems(query, item.children!));
//       }
//     }
//     return results;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SearchAnchor(
//       searchController: _searchController,
//       // The UI shown before the user types anything or while typing
//       builder: (BuildContext context, SearchController controller) {
//         return IconButton(
//           icon: const Icon(Icons.search_outlined),
//           onPressed: () {
//             controller.openView();
//           },
//         );
//       },

//       // The suggestions shown while the user is typing
//       suggestionsBuilder: (BuildContext context, SearchController controller) {
//         final String query = controller.text.trim();

//         // If nothing is typed yet, you can return an empty list or show some suggestions.
//         if (query.isEmpty) {
//           return const [];
//         }

//         // Perform the search among all items
//         final matchingItems = _searchAllItems(query, allItems);

//         // Create ListTiles for each matching item
//         return matchingItems.map((item) {
//           return ListTile(
//             title: Text(item.name),
//             onTap: () {
//               // Close the search view with the selected item name (not strictly required).
//               controller.closeView(item.name);

//               // Based on file type, navigate to different screens.
//               if (item.isFolder) {
//                 Navigator.of(context).push(PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) =>
//                       FolderScreenWidget(
//                         fileItems: item.children ?? [],
//                         folderName: item.name,
//                         colorScheme: Theme.of(context).colorScheme,
//                       ),
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) {
//                     const begin = Offset(1.0, 0.0);
//                     const end = Offset.zero;
//                     const curve = Curves.easeInOut;
//                     final tween = Tween(begin: begin, end: end)
//                         .chain(CurveTween(curve: curve));
//                     final offsetAnimation = animation.drive(tween);

//                     return SlideTransition(position: offsetAnimation, child: child);
//                   },
//                 ));
//               } else if (item.filePath != null) {
//                 final path = item.filePath!.toLowerCase();
//                 if (path.endsWith(".pdf")) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PdfViewerPage(filePath: item.filePath!, fileName: item.name,),
//                     ),
//                   );
//                 } else if (path.endsWith(".txt")) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TextFileViewerPage(filePath: item.filePath!,fileName: item.name,),
//                     ),
//                   );
//                 } else if (path.endsWith(".png") || path.endsWith(".jpg")) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ImageViewerPage(imagePath: item.filePath!,fileName: item.name,),
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Unsupported file type")),
//                   );
//                 }
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("No file path found")),
//                 );
//               }
//             },
//           );
//         }).toList();
//       },
//       dividerColor: Colors.blue,
//     );
//   }
// }









// IOS LOOK AND FEEL CODE

import 'package:document_management_main/utils/file_data_service_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show ColorScheme, Offset, PageRouteBuilder, SlideTransition, Theme; 
// ^ We still need Material symbols for things like ColorScheme or custom transitions.
//   But the UI components below are Cupertino-based.

// import 'package:document_management_main/data/file_data.dart';
import '../data/create_fileStructure.dart';
import '../files_viewer/image_viewer_page.dart';
import '../files_viewer/pdf_viewer_page.dart';
import '../files_viewer/text_viewer_page.dart';
import '../utils/file_data_service_util.dart';
import 'folder_screen_widget.dart';
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
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

  /// Open the iOS-style search page as a Cupertino page route.
  void _openSearchPage() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => SearchPage(
          onSearch: _searchAllItems,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.search),
      onPressed: _openSearchPage,
    );
  }
}

/// A dedicated iOS-style search page with a search bar at the top
/// and a list of results below.
class SearchPage extends StatefulWidget {
  final List<FileItemNew> Function(String query, List<FileItemNew> items) onSearch;

  const SearchPage({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<FileItemNew> _searchResults = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    final results = widget.onSearch(query, allItems);
    setState(() {
      _searchResults = results;
    });
  }

  /// Replaces SnackBar with a simple Cupertino dialog.
  void _showCupertinoAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void _onResultTap(FileItemNew item) {
    // If it's a folder, navigate to FolderScreenWidget
    if (item.isFolder) {
      Navigator.of(context).push(
        // You could use CupertinoPageRoute for a slide from the right
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FolderScreenWidget(
              fileItems: item.children ?? [],
              folderName: item.name,
              colorScheme: Theme.of(context).colorScheme,
              folderId: item.identifier,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    } 
    // Otherwise, check file extension
    else if (item.filePath != null) {
      final path = item.filePath!.toLowerCase();
      if (path.endsWith(".pdf")) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PdfViewerPage(
              filePath: item.filePath!,
              fileName: item.name,
            ),
          ),
        );
      } else if (path.endsWith(".txt")) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TextFileViewerPage(
              filePath: item.filePath!,
              fileName: item.name,
            ),
          ),
        );
      } else if (path.endsWith(".png") || path.endsWith(".jpg")) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ImageViewerPage(
              imagePath: item.filePath!,
              fileName: item.name,
            ),
          ),
        );
      } else {
        _showCupertinoAlert("Unsupported file type");
      }
    } else {
      _showCupertinoAlert("No file path found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSearchTextField(
          controller: _controller,
          onChanged: _performSearch,
          onSubmitted: _performSearch,
          placeholder: 'Search documents',
        ),
      ),
      child: SafeArea(
        child: _searchResults.isEmpty
            ? const Center(
                child: Text('Type above to search...', 
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    onPressed: () => _onResultTap(item),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.doc_text),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
