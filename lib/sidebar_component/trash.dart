// import 'package:document_management_main/data/create_fileStructure.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart'; // For ColorScheme and other references
// import 'package:document_management_main/apis/ikon_service.dart';
// import 'package:document_management_main/components/grid_view.dart';
// import 'package:document_management_main/components/list_view.dart';
// import 'package:document_management_main/data/file_data.dart';
// import 'package:document_management_main/utils/file_data_service_util.dart';
//
// class Trash extends StatefulWidget {
//   final ThemeMode themeMode;
//   final ColorScheme colorScheme;
//   final Function(bool isDarkMode) onThemeChanged;
//   final Function(ColorScheme colorScheme) onColorSchemeChanged;
//
//   const Trash({
//     super.key,
//     required this.themeMode,
//     required this.colorScheme,
//     required this.onThemeChanged,
//     required this.onColorSchemeChanged,
//   });
//
//   @override
//   State<StatefulWidget> createState() => _TrashState();
// }
//
// class _TrashState extends State<Trash> {
//   /// Toggle between Grid and List
//   bool localIsGridView = false;
//
//   /// Full list of all items
//   List<FileItemNew> allItems = [];
//
//   /// Only trashed items (isDeleted = true)
//   List<FileItemNew> trashedItems = [];
//
//   /// Indicates if we are currently loading data
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   /// Async method to fetch all items, then filter out trashed items
//   Future<void> _loadData() async {
//     try {
//       // 1. Fetch all file/folder data
//       final newAllItems = await fetchFileStructure();
//
//       // 2. Filter out trashed items
//       final List<FileItemNew> newTrashed = [];
//       _getTrashedData(newAllItems, newTrashed);
//
//       // 3. Update state
//       setState(() {
//         allItems = newAllItems;
//         trashedItems = newTrashed;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       // Optionally show an error
//       showCupertinoDialog(
//         context: context,
//         builder: (context) => CupertinoAlertDialog(
//           title: const Text("Error"),
//           content: Text("Error loading trash data: $e"),
//           actions: [
//             CupertinoDialogAction(
//               child: const Text("OK"),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   /// Recursively find all items where isDeleted == true
//   void _getTrashedData(List<FileItemNew> items, List<FileItemNew> trashList) {
//     for (final item in items) {
//       if (item.isDeleted) {
//         trashList.add(item);
//       }
//       if (item.isFolder && item.children != null) {
//         _getTrashedData(item.children!, trashList);
//       }
//     }
//   }
//
//   /// Toggle view between Grid and List
//   void _toggleViewMode() {
//     setState(() {
//       localIsGridView = !localIsGridView;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeData = ThemeData.from(
//       colorScheme: widget.colorScheme,
//       textTheme: ThemeData.light().textTheme,
//     ).copyWith(
//       brightness: widget.themeMode == ThemeMode.dark
//           ? Brightness.dark
//           : Brightness.light,
//     );
//
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: const Text("Trash"),
//         leading: CupertinoButton(
//           padding: EdgeInsets.zero,
//           onPressed: () => Navigator.pop(context),
//           child: Icon(
//             CupertinoIcons.back,
//             color: widget.colorScheme.secondary,
//           ),
//         ),
//       ),
//       child: SafeArea(
//         child: _isLoading
//             ? const Center(child: CupertinoActivityIndicator())
//             : Column(
//           children: [
//             if (trashedItems.isNotEmpty)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   CupertinoButton(
//                     padding: EdgeInsets.zero,
//                     child: Icon(
//                       localIsGridView
//                           ? CupertinoIcons.list_bullet
//                           : CupertinoIcons.square_grid_2x2,
//                     ),
//                     onPressed: _toggleViewMode,
//                   ),
//                   const SizedBox(width: 28.0),
//                 ],
//               ),
//             // If there are no trashed items after loading, show something else
//             if (trashedItems.isEmpty)
//               const Expanded(
//                 child: Center(
//                   child: Text("No items in Trash"),
//                 ),
//               )
//             else
//               Expanded(
//                 child: localIsGridView
//                     ? GridLayout(
//                   items: trashedItems,
//                   colorScheme: widget.colorScheme,
//                   isTrashed: true,
//                 )
//                     : CustomListView(
//                   items: trashedItems,
//                   colorScheme: widget.colorScheme,
//                   isTrashed: true,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:document_management_main/data/create_fileStructure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For ColorScheme and other references
import 'package:document_management_main/apis/ikon_service.dart';
import 'package:document_management_main/components/grid_view.dart';
import 'package:document_management_main/components/list_view.dart';
import 'package:document_management_main/data/file_data.dart';
import 'package:document_management_main/utils/file_data_service_util.dart';

class Trash extends StatefulWidget {
  final ThemeMode themeMode;
  final ColorScheme colorScheme;
  final Function(bool isDarkMode) onThemeChanged;
  final Function(ColorScheme colorScheme) onColorSchemeChanged;

  const Trash({
    super.key,
    required this.themeMode,
    required this.colorScheme,
    required this.onThemeChanged,
    required this.onColorSchemeChanged,
  });

  @override
  State<StatefulWidget> createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  /// Toggle between Grid and List
  bool localIsGridView = false;

  /// Full list of all items
  List<FileItemNew> allItems = [];

  /// Only trashed items (isDeleted = true)
  List<FileItemNew> trashedItems = [];

  /// Indicates if we are currently loading data
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Async method to fetch all items, then filter out trashed items
  Future<void> _loadData() async {
    try {
      // 1. Fetch all file/folder data
      final newAllItems = await fetchFileStructure();

      // 2. Filter out trashed items
      final List<FileItemNew> newTrashed = [];
      _getTrashedData(newAllItems, newTrashed);

      // 3. Update state
      setState(() {
        allItems = newAllItems;
        trashedItems = newTrashed;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Optionally show an error
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("Error"),
          content: Text("Error loading trash data: $e"),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  /// Recursively find all items where isDeleted == true
  void _getTrashedData(List<FileItemNew> items, List<FileItemNew> trashList) {
    for (final item in items) {
      if (item.isDeleted) {
        trashList.add(item);
      }
      if (item.isFolder && item.children != null) {
        _getTrashedData(item.children!, trashList);
      }
    }
  }

  /// Toggle view between Grid and List
  void _toggleViewMode() {
    setState(() {
      localIsGridView = !localIsGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData.from(
      colorScheme: widget.colorScheme,
      textTheme: ThemeData.light().textTheme,
    ).copyWith(
      brightness: widget.themeMode == ThemeMode.dark
          ? Brightness.dark
          : Brightness.light,
    );

    final bool _isDarkMode = widget.themeMode == ThemeMode.light ? false : true;

    return CupertinoPageScaffold(
      backgroundColor: widget.themeMode == ThemeMode.dark
          ? Colors.black  // Dark mode background
          : Colors.white, // Light mode background
      navigationBar: CupertinoNavigationBar(
        middle: Text("Trash",style: TextStyle(color: widget.colorScheme.primary,fontSize: 22),),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.back,
            color: widget.themeMode == ThemeMode.dark
                ? Colors.white  // White for dark mode
                : Colors.black, // Black for light mode
            size: 28.0,  // Increase the size
          ),
        ),
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(
          child: CupertinoActivityIndicator(
            radius: 20.0,  // Increase the size of the loading indicator
          ),
        )
            : Column(
          children: [
            if (trashedItems.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _toggleViewMode,
                    child: Icon(
                      color: widget.colorScheme.primary,
                      localIsGridView
                          ? CupertinoIcons.list_bullet
                          : CupertinoIcons.square_grid_2x2,
                    ),
                  ),
                  const SizedBox(width: 28.0),
                ],
              ),
            // If there are no trashed items after loading, show something else
            if (trashedItems.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("No items in Trash"),
                ),
              )
            else
              Expanded(
                child: localIsGridView
                    ? GridLayout(
                  items: trashedItems,
                  colorScheme: widget.colorScheme,
                  isTrashed: true,
                  isDarkMode: _isDarkMode,
                )
                    : CustomListView(
                  items: trashedItems,
                  colorScheme: widget.colorScheme,
                  isTrashed: true,
                  isDarkMode: _isDarkMode,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
