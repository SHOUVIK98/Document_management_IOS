// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// import 'package:document_management_main/components/grid_view.dart';
// import 'package:document_management_main/data/file_data.dart';
// import 'package:document_management_main/utils/rename_folder_utils.dart';
// import 'package:document_management_main/components/list_view.dart';
// import 'package:document_management_main/utils/Starred_item_utils.dart';
// import 'package:document_management_main/utils/delete_item_utils.dart';
// import 'package:document_management_main/widgets/floating_action_button_widget.dart';

// // Import the separate file that fetches data
// import '../data/create_fileStructure.dart';
// import '../utils/file_data_service_util.dart';

// class HomeFragment extends StatefulWidget {
//   final ThemeData? theme;
//   final ColorScheme colorScheme;
//   final ThemeMode themeMode;
//   final void Function(bool isDark) updateTheme;
//   final void Function(ColorScheme newScheme) updateColorScheme;
//   final bool isGridView;

//   const HomeFragment({
//     super.key,
//     this.theme,
//     required this.colorScheme,
//     required this.themeMode,
//     required this.updateTheme,
//     required this.updateColorScheme,
//     required this.isGridView,
//   });

//   @override
//   State<HomeFragment> createState() => _HomeFragmentState();
// }

// class _HomeFragmentState extends State<HomeFragment> {
//   /// This list holds the actual file items we want to display.
//   List<FileItemNew> currentItems = [];

//   /// Track whether we are loading data.
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch data as soon as the widget is mounted
//     _loadData();
//   }

//   /// Called in initState and can also be called on pull-to-refresh.
//   Future<void> _loadData() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Use our helper function to fetch the entire file structure
//       final fileStructure = await fetchFileStructure();

//       // Remove any deleted files
//       removeDeletedFilesMine(fileStructure);

//       // Update the state with the new items
//       setState(() {
//         currentItems = fileStructure;
//         _isLoading = false;
//       });
//     } catch (e) {
//       // In case of error, we still turn off the loading indicator
//       setState(() {
//         _isLoading = false;
//       });

//       // Show a SnackBar or handle error
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load data: $e')),
//       );
//     }
//   }

//   /// Method to handle pull-down refresh
//   Future<void> _refreshData() async {
//     await _loadData();
//   }

//   /// Recursively remove any deleted files/folders
//   void removeDeletedFilesMine(List<FileItemNew> items) {
//     items.removeWhere((item) => item.isDeleted);

//     for (final item in items) {
//       if (item.isFolder && item.children != null) {
//         removeDeletedFilesMine(item.children!);
//       }
//     }
//   }

//   /// Callback for the floating action button when new files are added
//   void _onFilesAdded(List<FileItemNew> newFiles) {
//     setState(() {
//       currentItems.insertAll(0, newFiles);
//       Navigator.pop(context);
//     });
//   }

//   /// Toggle starred state for a file/folder
//   void _addToStarred(FileItemNew item) {
//     setState(() {
//       item.isStarred = !item.isStarred;
//     });
//     addToStarred(item.isFolder, item.identifier, "starred", item.isStarred,
//         item.filePath);
//   }

//   /// Rename a folder
//   void _renameFolder(String newName, FileItemNew? item) async {
//     if (item == null) return;
//     setState(() {
//       item.name = newName;
//     });
//     try {
//       renameFolder(context, item);
//     } catch (e) {
//       print("Error during renaming folder: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('An error occurred while renaming the folder.')),
//       );
//     }
//   }

//   /// Delete a file or folder
//   void _deleteFileOrFolder(FileItemNew item, dynamic parentFolderId) async {
//     setState(() {
//       item.isDeleted = true;
//     });

//     await deleteFilesOrFolder(item, parentFolderId, context);
//     _refreshData(); // Refresh after deletion
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Decide if we display a grid or list
//     Widget currentView = widget.isGridView
//         ? GridLayout(
//       items: currentItems,
//       onStarred: _addToStarred,
//       colorScheme: widget.colorScheme,
//       renameFolder: _renameFolder,
//       deleteItem: _deleteFileOrFolder,
//     )
//         : CustomListView(
//       items: currentItems,
//       onStarred: _addToStarred,
//       colorScheme: widget.colorScheme,
//       renameFolder: _renameFolder,
//       deleteItem: _deleteFileOrFolder,
//     );

//     // Use the correct theme for the widget
//     return Theme(
//       data: ThemeData.from(
//         colorScheme: widget.colorScheme,
//         textTheme: ThemeData.light().textTheme,
//       ).copyWith(
//         brightness: widget.themeMode == ThemeMode.dark
//             ? Brightness.dark
//             : Brightness.light,
//       ),
//       child: Scaffold(
//         floatingActionButton: FloatingActionButtonWidget(
//           onFilesAdded: _onFilesAdded,
//           isFolderUpload: false,
//           folderName: "",
//           colorScheme: widget.colorScheme,
//         ),
//         // If loading, show Shimmer placeholder, else show the actual grid/list
//         body: _isLoading
//             ? _buildShimmerPlaceholder()
//             : RefreshIndicator(
//           onRefresh: _refreshData,
//           child: currentView,
//         ),
//       ),
//     );
//   }

//   /// A simple Shimmer-based placeholder while data loads
//   Widget _buildShimmerPlaceholder() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: ListView.builder(
//         itemCount: 8, // Show as many placeholders as you like
//         itemBuilder: (context, index) {
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             height: 60,
//             color: Colors.white,
//           );
//         },
//       ),
//     );
//   }
// }










// IOS LOOK AND FEEL CODE



// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
//
// import 'package:flutter/material.dart'
//     show ColorScheme, Curves, MaterialApp, Offset, PageRouteBuilder, Shimmer, SnackBar, Theme, ThemeData, ThemeMode;
// // ^ We import just what we need from Material, mostly for color schemes, transitions, or Shimmer.
//
// import 'package:shimmer/shimmer.dart';
// import 'package:document_management_main/components/grid_view.dart';
// import 'package:document_management_main/data/file_data.dart';
// import 'package:document_management_main/utils/rename_folder_utils.dart';
// import 'package:document_management_main/components/list_view.dart';
// import 'package:document_management_main/utils/Starred_item_utils.dart';
// import 'package:document_management_main/utils/delete_item_utils.dart';
// import 'package:document_management_main/widgets/floating_action_button_widget.dart';
//
// // Import the separate file that fetches data
// import '../data/create_fileStructure.dart';
// import '../utils/file_data_service_util.dart';
//
// class HomeFragment extends StatefulWidget {
//   final ThemeData? theme;
//   final ColorScheme colorScheme;
//   final ThemeMode themeMode;
//   final void Function(bool isDark) updateTheme;
//   final void Function(ColorScheme newScheme) updateColorScheme;
//   final bool isGridView;
//
//   const HomeFragment({
//     super.key,
//     this.theme,
//     required this.colorScheme,
//     required this.themeMode,
//     required this.updateTheme,
//     required this.updateColorScheme,
//     required this.isGridView,
//   });
//
//   @override
//   State<HomeFragment> createState() => _HomeFragmentState();
// }
//
// class _HomeFragmentState extends State<HomeFragment> {
//   /// This list holds the actual file items we want to display.
//   List<FileItemNew> currentItems = [];
//
//   /// Track whether we are loading data.
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   /// Fetch data and remove any deleted files.
//   Future<void> _loadData() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       // Use our helper function to fetch the entire file structure.
//       final fileStructure = await fetchFileStructure();
//
//       // Remove any deleted files.
//       removeDeletedFilesMine(fileStructure);
//
//       setState(() {
//         currentItems = fileStructure;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showErrorDialog('Failed to load data: $e');
//     }
//   }
//
//   /// Method to handle pull-down refresh (invoked by CupertinoSliverRefreshControl).
//   Future<void> _refreshData() async {
//     await _loadData();
//   }
//
//   /// Recursively remove any deleted files/folders.
//   void removeDeletedFilesMine(List<FileItemNew> items) {
//     items.removeWhere((item) => item.isDeleted);
//
//     for (final item in items) {
//       if (item.isFolder && item.children != null) {
//         removeDeletedFilesMine(item.children!);
//       }
//     }
//   }
//
//   /// Show a Cupertino-style alert dialog instead of a SnackBar.
//   void _showErrorDialog(String message) {
//     showCupertinoDialog(
//       context: context,
//       builder: (ctx) => CupertinoAlertDialog(
//         title: const Text("Error"),
//         content: Text(message),
//         actions: [
//           CupertinoDialogAction(
//             child: const Text("OK"),
//             onPressed: () => Navigator.of(ctx).pop(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Callback for the floating action button when new files are added.
//   void _onFilesAdded(List<FileItemNew> newFiles) {
//     setState(() {
//       currentItems.insertAll(0, newFiles);
//       Navigator.pop(context); // close any open dialog or bottom sheet
//     });
//   }
//
//   /// Toggle starred state for a file/folder
//   void _addToStarred(FileItemNew item) {
//     setState(() {
//       item.isStarred = !item.isStarred;
//     });
//     addToStarred(
//       item.isFolder,
//       item.identifier,
//       "starred",
//       item.isStarred,
//       item.filePath,
//     );
//   }
//
//   /// Rename a folder
//   void _renameFolder(String newName, FileItemNew? item) async {
//     if (item == null) return;
//     setState(() {
//       item.name = newName;
//     });
//     try {
//       renameFolder(context, item);
//     } catch (e) {
//       _showErrorDialog("An error occurred while renaming the folder.");
//     }
//   }
//
//   /// Delete a file or folder
//   void _deleteFileOrFolder(FileItemNew item, dynamic parentFolderId) async {
//     setState(() {
//       item.isDeleted = true;
//     });
//     await deleteFilesOrFolder(item, parentFolderId, context);
//     _refreshData(); // Refresh after deletion
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Decide if we display a grid or list
//     final Widget currentView = widget.isGridView
//         ? GridLayout(
//             items: currentItems,
//             onStarred: _addToStarred,
//             colorScheme: widget.colorScheme,
//             renameFolder: _renameFolder,
//             deleteItem: _deleteFileOrFolder,
//           )
//         : CustomListView(
//             items: currentItems,
//             onStarred: _addToStarred,
//             colorScheme: widget.colorScheme,
//             renameFolder: _renameFolder,
//             deleteItem: _deleteFileOrFolder,
//           );
//
//     // If loading, show a shimmer placeholder; else show the main content
//     final Widget content = _isLoading
//         ? _buildShimmerPlaceholder()
//         : _buildCupertinoRefreshView(currentView);
//
//     return CupertinoPageScaffold(
//         // If you want a navigation bar, you can add it here:
//         // navigationBar: CupertinoNavigationBar(
//         //   middle: Text("Home"),
//         // ),
//
//         // We use SafeArea + a Stack to place the "floating" button manually.
//         child: SafeArea(
//           child: Stack(
//             children: [
//               // Main content (list/grid + pull-to-refresh)
//               content,
//
//               // A manual "floating" button in the bottom-right corner
//               Positioned(
//                 right: 16,
//                 bottom: 16,
//                 child: FloatingActionButtonWidget(
//                   onFilesAdded: _onFilesAdded,
//                   isFolderUpload: false,
//                   folderName: "",
//                   colorScheme: widget.colorScheme,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//
//     // return CupertinoPageScaffold(
//     //   child: SafeArea(
//     //     child: Stack(
//     //       children: [
//     //         // Wrap content in Localizations
//     //         Localizations(
//     //           delegates: const [
//     //             GlobalMaterialLocalizations.delegate,
//     //             GlobalWidgetsLocalizations.delegate,
//     //           ],
//     //           locale: Locale('en', 'US'),
//     //           child: content,  // Your GridView or ListView
//     //         ),
//     //
//     //         // Floating Action Button
//     //         Positioned(
//     //           right: 16,
//     //           bottom: 16,
//     //           child: FloatingActionButtonWidget(
//     //             onFilesAdded: _onFilesAdded,
//     //             isFolderUpload: false,
//     //             folderName: "",
//     //             colorScheme: widget.colorScheme,
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//
//   }
//
//   /// Builds a shimmer-based placeholder while data loads.
//   Widget _buildShimmerPlaceholder() {
//     return Shimmer.fromColors(
//       baseColor: CupertinoColors.systemGrey.resolveFrom(context).withOpacity(0.3),
//       highlightColor:
//           CupertinoColors.systemGrey.resolveFrom(context).withOpacity(0.1),
//       child: ListView.builder(
//         itemCount: 8, // show as many placeholders as you like
//         itemBuilder: (context, index) {
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             height: 60,
//             color: CupertinoColors.white,
//           );
//         },
//       ),
//     );
//   }
//
//   /// Wraps our currentView in a CustomScrollView + CupertinoSliverRefreshControl
//   /// to replicate pull-to-refresh behavior in iOS style.
//   Widget _buildCupertinoRefreshView(Widget child) {
//     return CustomScrollView(
//       slivers: [
//         CupertinoSliverRefreshControl(onRefresh: _refreshData),
//         SliverFillRemaining(
//           child: child,
//         ),
//       ],
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:document_management_main/components/grid_view.dart';
// import 'package:document_management_main/data/file_data.dart';
import 'package:document_management_main/utils/rename_folder_utils.dart';
import 'package:document_management_main/components/list_view.dart';
import 'package:document_management_main/utils/Starred_item_utils.dart';
import 'package:document_management_main/utils/delete_item_utils.dart';
import 'package:document_management_main/widgets/floating_action_button_widget.dart';

// Import the separate file that fetches data
import '../data/create_fileStructure.dart';
import '../utils/file_data_service_util.dart';

class HomeFragment extends StatefulWidget {
  final ThemeData? theme;
  final ColorScheme colorScheme;
  final ThemeMode themeMode;
  final void Function(bool isDark) updateTheme;
  final void Function(ColorScheme newScheme) updateColorScheme;
  final bool isGridView;

  const HomeFragment({
    super.key,
    this.theme,
    required this.colorScheme,
    required this.themeMode,
    required this.updateTheme,
    required this.updateColorScheme,
    required this.isGridView,
  });

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  List<FileItemNew> currentItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Fetch data and remove any deleted files.
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final fileStructure = await fetchFileStructure();
      removeDeletedFilesMine(fileStructure);
      getItemData(fileStructure);

      setState(() {
        currentItems = fileStructure;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Failed to load data: $e');
    }
  }

  /// Reset and refresh data
  Future<void> _resetData() async {
    setState(() {
      _isLoading = true;
      currentItems.clear(); // Clear current items before reloading
    });

    await _loadData(); // Calls _loadData() to reload data
  }

  /// Remove any deleted files/folders recursively.
  void removeDeletedFilesMine(List<FileItemNew> items) {
    items.removeWhere((item) => item.isDeleted);
    for (final item in items) {
      if (item.isFolder && item.children != null) {
        removeDeletedFilesMine(item.children!);
      }
    }
  }

  /// Show a Cupertino-style error dialog.
  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  /// Callback for adding files.
  void _onFilesAdded(List<FileItemNew> newFiles) {
    setState(() {
      currentItems.insertAll(0, newFiles);
      Navigator.pop(context); // Close any open dialog
    });
  }

  /// Toggle starred state
  void _addToStarred(FileItemNew item) {
    setState(() {
      item.isStarred = !item.isStarred;
    });
    addToStarred(
      item.isFolder,
      item.identifier,
      "starred",
      item.isStarred,
      item.filePath,
    );
  }

  /// Rename a folder
  void _renameFolder(String newName, FileItemNew? item) async {
    if (item == null) return;
    setState(() {
      item.name = newName;
    });
    try {
      renameFolder(context, item);
    } catch (e) {
      _showErrorDialog("An error occurred while renaming the folder.");
    }
  }

  /// Delete a file or folder
  void _deleteFileOrFolder(FileItemNew item, dynamic parentFolderId) async {
    setState(() {
      item.isDeleted = true;
    });
    await deleteFilesOrFolder(item, parentFolderId, context);
    _resetData(); // Call reset after deletion
  }

  @override
  Widget build(BuildContext context) {
    final Widget currentView = widget.isGridView
        ? GridLayout(
      items: currentItems,
      onStarred: _addToStarred,
      colorScheme: widget.colorScheme,
      renameFolder: _renameFolder,
      deleteItem: _deleteFileOrFolder,
    )
        : CustomListView(
      items: currentItems,
      onStarred: _addToStarred,
      colorScheme: widget.colorScheme,
      renameFolder: _renameFolder,
      deleteItem: _deleteFileOrFolder,
    );

    final Widget content = _isLoading
        ? _buildShimmerPlaceholder()
        : _buildCupertinoRefreshView(currentView);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
         middle: const Text("Home"),
        trailing: GestureDetector(
          onTap: _resetData, // Reset button works now!
          child: const Icon(CupertinoIcons.refresh_bold),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            content,
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButtonWidget(
                onFilesAdded: _onFilesAdded,
                isFolderUpload: false,
                folderName: "",
                colorScheme: widget.colorScheme,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shimmer placeholder while loading
  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: CupertinoColors.systemGrey.resolveFrom(context).withOpacity(0.3),
      highlightColor:
      CupertinoColors.systemGrey.resolveFrom(context).withOpacity(0.1),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 60,
            color: CupertinoColors.white,
          );
        },
      ),
    );
  }

  /// Wraps content in a refreshable scroll view
  Widget _buildCupertinoRefreshView(Widget child) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: _resetData, // Pull-to-refresh now resets
        ),
        SliverFillRemaining(
          child: child,
        ),
      ],
    );
  }
}
