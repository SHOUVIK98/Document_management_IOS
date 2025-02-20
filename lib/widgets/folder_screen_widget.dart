
/*
* DO NOT TOUCH THIS FILE, OR YOU WILL FACE THE WRATH OF THE DEMON(ME)
* */

// import 'package:document_management_main/widgets/search_bar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../apis/ikon_service.dart';
// import '../components/grid_view.dart';
// import '../components/list_view.dart';
// import '../data/create_fileStructure.dart';
// import '../data/file_class.dart';
// import '../utils/delete_item_utils.dart';
// import 'floating_action_button_widget.dart';
// import 'package:document_management_main/data/file_data.dart';

// class FolderScreenWidget extends StatefulWidget {
//   final List<FileItemNew> fileItems;
//   final String folderName;
//   final dynamic parentId;
//   final bool isTrashed;

//   // final bool isLightTheme;
//   final ColorScheme colorScheme;

//   const FolderScreenWidget(
//       {super.key,
//       required this.fileItems,
//       required this.folderName,
//       required this.colorScheme,
//       this.isTrashed = false,
//       this.parentId});

//   @override
//   State<FolderScreenWidget> createState() {
//     return _FolderScreenWidget();
//   }
// }

// class _FolderScreenWidget extends State<FolderScreenWidget> {
//   List<FileItemNew> currentItems = [];
//   bool localIsGridView = false;

//   List<FileItemNew>? findFileItems(String folderName, List<FileItemNew> items) {
//     for (final item in items) {
//       if (item.name == folderName) {
//         return item.children;
//       } else if (item.isFolder && item.children != null) {
//         final result = findFileItems(folderName, item.children!);
//         if (result != null) {
//           return result;
//         }
//       }
//     }
//     return null;
//   }

//   FileItemNew? findFolder(String folderName, List<FileItemNew> items) {
//     for (final item in items) {
//       if (item.name == folderName) {
//         return item;
//       } else if (item.isFolder && item.children != null) {
//         final result = findFolder(folderName, item.children!);
//         if (result != null) {
//           return result;
//         }
//       }
//     }
//     return null;
//   }

//   List<FileItemNew> allActiveItems = [];

//   @override
//   void initState() {
//     super.initState();
//     removeDeletedFiles(widget.fileItems);
//     currentItems = widget.fileItems;
//   }

//   Future<void> _refreshData() async {
//     try {
//       // Fetch file instances
//       final List<Map<String, dynamic>> fileInstanceData =
//           await IKonService.iKonService.getMyInstancesV2(
//         processName: "File Manager - DM",
//         predefinedFilters: {"taskName": "Viewer Access"},
//         processVariableFilters: null,
//         taskVariableFilters: null,
//         mongoWhereClause: null,
//         projections: ["Data"],
//         allInstance: false,
//       );
//       print("FileInstance Data: ");
//       print(fileInstanceData);

//       // Fetch folder instances
//       final List<Map<String, dynamic>> folderInstanceData =
//           await IKonService.iKonService.getMyInstancesV2(
//         processName: "Folder Manager - DM",
//         predefinedFilters: {"taskName": "Viewer Access"},
//         processVariableFilters: null,
//         taskVariableFilters: null,
//         mongoWhereClause: null,
//         projections: ["Data"],
//         allInstance: false,
//       );
//       print("FolderInstance Data: ");
//       print(folderInstanceData);

//       final Map<String, dynamic> userData =
//           await IKonService.iKonService.getLoggedInUserProfile();

//       final List<Map<String, dynamic>> starredInstanceData =
//           await IKonService.iKonService.getMyInstancesV2(
//         processName: "User Specific Folder and File Details - DM",
//         predefinedFilters: {"taskName": "View Details"},
//         processVariableFilters: {"user_id": userData["USER_ID"]},
//         taskVariableFilters: null,
//         mongoWhereClause: null,
//         projections: ["Data"],
//         allInstance: false,
//       );

//       final List<Map<String, dynamic>> trashInstanceData =
//           await IKonService.iKonService.getMyInstancesV2(
//         processName: "Delete Folder Structure - DM",
//         predefinedFilters: {"taskName": "Delete Folder And Files"},
//         processVariableFilters: null,
//         taskVariableFilters: null,
//         mongoWhereClause: null,
//         projections: ["Data"],
//         allInstance: false,
//       );

//       // Create file structure
//       final fileStructure = createFileStructure(fileInstanceData,
//           folderInstanceData, starredInstanceData, trashInstanceData);
//       getItemData(fileStructure);

//       // Update the state with the new file structure
//       setState(() {
//         // allActiveItems = [];
//         removeDeletedFiles(widget.fileItems);
//         currentItems = widget.fileItems;
//         // currentItems = fileStructure;
//       });
//     } catch (e) {
//       // Handle any errors here
//       print("Error during refresh: $e");
//       // Optionally, show a snackbar or dialog to inform the user
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to refresh data. Please try again.')),
//       );
//     }
//   }

//   // final FileItemNew folder;
//   void _onFilesAdded(List<FileItemNew> newFiles) {
//     setState(() {
//       currentItems.addAll(newFiles);
//       final folder = findFolder(widget.folderName, allItems);
//       if (folder != null) {
//         folder.children = currentItems;
//       } else {
//         print("Folder '${widget.folderName}' not found while adding files.");
//       }
//       Navigator.pop(context);
//     });
//   }

//   void _addToStarred(FileItemNew item) {
//     setState(() {
//       item.isStarred = !item.isStarred;
//     });
//   }

//   void _toggleViewMode() {
//     setState(() {
//       localIsGridView = !localIsGridView;
//     });
//   }

//   Future<void> _renameFolder(String newName, FileItemNew? item) async {
//     setState(() {
//       item!.name = newName;
//     });

//     String identifier = item!.identifier;
//     String taskId;
//     print("Rename folder called");
//     item.name = newName;

//     final List<Map<String, dynamic>> folderInstanceData =
//         await IKonService.iKonService.getMyInstancesV2(
//       processName: "Folder Manager - DM",
//       predefinedFilters: {"taskName": "Editor Access"},
//       processVariableFilters: {"folder_identifier": identifier},
//       taskVariableFilters: null,
//       mongoWhereClause: null,
//       projections: ["Data"],
//       allInstance: false,
//     );

//     print("Task id:");

//     print(folderInstanceData[0]["taskId"]);
//     taskId = folderInstanceData[0]["taskId"];

//     bool result = await IKonService.iKonService.invokeAction(
//         taskId: taskId,
//         transitionName: "Update Editor Access",
//         data: {"folder_identifier": item.identifier, "folderName": item.name},
//         processIdentifierFields: null);
//   }

//   void _deleteFileOrFolder(FileItemNew item, dynamic parentFolderId) async {
//     setState(() {
//       item.isDeleted = true;
//     });

//     await deleteFilesOrFolder(item, parentFolderId, context);

//     _refreshData();
//   }

//   void removeDeletedFiles(items) {
//     for (var item in items) {
//       if (item.isDeleted) {
//         items.remove(item);
//         return;
//       }
//       if (item.isFolder && item.children!=null) {
//         removeDeletedFiles(item.children!);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.folderName,
//           style: TextStyle(color: widget.colorScheme.primary),
//         ),
//         leading: Padding(
//           padding: const EdgeInsets.all(2.0),
//           child: GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: const Icon(Icons.arrow_back),
//           ),
//         ),
//         actions: const [
//           const SearchBarWidget(),
//           Padding(
//             padding: EdgeInsets.only(right: 12.0),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButtonWidget(
//         onFilesAdded: _onFilesAdded,
//         isFolderUpload: true,
//         folderName: widget.folderName,
//         colorScheme: widget.colorScheme,
//         // parentFolderId: findFolder(widget.folderName, allItems)?.fileId,
//         parentFolderId: widget.parentId,
//       ),
//       body: Column(
//         children: [
//           if (currentItems.isNotEmpty)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // const Padding(padding: EdgeInsets.only(left: 340.0)),
//                 IconButton(
//                   // icon: Icon(widget.isGridView ? Icons.view_list : Icons.grid_view),
//                   icon:
//                       Icon(localIsGridView ? Icons.view_list : Icons.grid_view),

//                   onPressed: () {
//                     // widget.toggleViewMode;
//                     // setState(() {
//                     //   localIsGridView = !localIsGridView;
//                     // });
//                     _toggleViewMode();
//                   },
//                 ),
//                 const SizedBox(width: 28.0),
//               ],
//             ),
//           Expanded(
//             child: localIsGridView // widget.isGridView
//                 ? GridLayout(
//                     items: currentItems,
//                     onStarred: _addToStarred,
//                     colorScheme: widget.colorScheme,
//                     parentFolderId: widget.parentId,
//                     renameFolder: _renameFolder,
//                     deleteItem: _deleteFileOrFolder,
//                     isTrashed: widget.isTrashed,
//                   )
//                 : CustomListView(
//                     items: currentItems,
//                     onStarred: _addToStarred,
//                     colorScheme: widget.colorScheme,
//                     parentFolderId: widget.parentId,
//                     renameFolder: _renameFolder,
//                     deleteItem: _deleteFileOrFolder,
//                     isTrashed: widget.isTrashed,
//                   ),
//           ),
//           // GridLayout(items: currentItems, onStarred: _addToStarred, isGridView: widget.isGridView, toggleViewMode: widget.toggleViewMode),
//         ],
//       ),
//     );
//   }
// }

// IOS LOOK AND FEEL CODE:

import 'package:document_management_main/utils/file_data_service_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For ColorScheme and other references
import 'package:document_management_main/widgets/search_bar_widget.dart';
import 'package:document_management_main/components/grid_view.dart';
import 'package:document_management_main/components/list_view.dart';
import 'package:document_management_main/data/create_fileStructure.dart';
import 'package:document_management_main/data/file_class.dart';
import 'package:document_management_main/utils/delete_item_utils.dart';
import 'package:document_management_main/widgets/floating_action_button_widget.dart';
import 'package:shimmer/shimmer.dart';

import 'search_bar_widget_ios.dart';
// import 'package:document_management_main/data/file_data.dart';

class FolderScreenWidget extends StatefulWidget {
  final List<FileItemNew> fileItems;
  final String folderName;
  final dynamic parentId;
  final bool isTrashed;
  final String folderId;
  final ColorScheme colorScheme;
  final Function? homeRefreshData;
  final bool? isDarkMode;

  const FolderScreenWidget({
    super.key,
    required this.fileItems,
    required this.folderName,
    required this.colorScheme,
    this.isTrashed = false,
    required this.folderId,
    this.parentId,
    this.homeRefreshData, 
    this.isDarkMode,
  });

  @override
  State<FolderScreenWidget> createState() {
    return _FolderScreenWidget();
  }
}

class _FolderScreenWidget extends State<FolderScreenWidget> {
  List<FileItemNew> currentItems = [];
  bool localIsGridView = true;
  bool _isLoading = false;

  List<FileItemNew>? findFileItems(String folderName, List<FileItemNew> items) {
    for (final item in items) {
      if (item.name == folderName) {
        return item.children;
      } else if (item.isFolder && item.children != null) {
        final result = findFileItems(folderName, item.children!);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  FileItemNew? findFolder(String folderName, List<FileItemNew> items) {
    for (final item in items) {
      if (item.name == folderName) {
        return item;
      } else if (item.isFolder && item.children != null) {
        final result = findFolder(folderName, item.children!);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  List<FileItemNew> allActiveItems = [];

  @override
  void initState() {
    super.initState();
    removeDeletedFiles(widget.fileItems);
    currentItems = widget.fileItems;
  }

  Future<void> _refreshData() async {
    // try {
    //   // Fetch data and update the file structure (same as before)
    //   final fileStructure = await fetchFileStructure();

    //   setState(() {
    //     removeDeletedFiles(widget.fileItems);
    //     currentItems = widget.fileItems;
    //   });
    // } catch (e) {
    //   print("Error during refresh: $e");
    //   // Optionally show a Cupertino-style alert dialog or other message
    // }

    try {
      // Fetch file instances
      final fileStructure = await fetchFileStructure();

      // Update the state with the new file structure
      setState(() {
        // allActiveItems = [];
        FileItemNew fileItem = fileStructure
            .firstWhere((item) => item.identifier == widget.folderId);
        List<FileItemNew> fileItems = fileItem.children!;
        removeDeletedFiles(fileItems);
        currentItems = fileItems;
      _isLoading = false;
        // removeDeletedFiles(widget.fileItems);
        // currentItems = widget.fileItems;
        // currentItems = fileStructure;
      });
    } catch (e) {
      // Handle any errors here
      print("Error during refresh: $e");
      // Optionally, show a snackbar or dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to refresh data. Please try again.')),
      );
    }
  }

  void _onFilesAdded(List<FileItemNew> newFiles) {
    setState(() {
      currentItems.addAll(newFiles);
      final folder = findFolder(widget.folderName, allItems);
      if (folder != null) {
        folder.children = currentItems;
      } else {
        print("Folder '${widget.folderName}' not found while adding files.");
      }
      Navigator.pop(context);
    });
  }

  void _addToStarred(FileItemNew item) {
    setState(() {
      item.isStarred = !item.isStarred;
    });
  }

  void _toggleViewMode() {
    setState(() {
      localIsGridView = !localIsGridView;
    });
  }

  void setFilteredData(List<String> filteredFiles) {
    setState(() {
      filteredFiles = filteredFiles;
    });
  }

  void pasteItem() {
    setState(() {
      _isLoading = true;
    });
    _refreshData();
    widget.homeRefreshData!();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          widget.folderName,
          style: TextStyle(color: widget.colorScheme.primary),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                setState(() {
                  _isLoading = true;
                });
                _refreshData();
              },
              child: Icon(
                CupertinoIcons.refresh,
                color: widget.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
            //   child: SearchBarWidget(),
            // ),
          ],
        ),
      ),
      child: FileSearchScreen(
        setFilteredData: setFilteredData,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (currentItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _toggleViewMode,
                        child: Icon(
                          localIsGridView
                              ? CupertinoIcons.list_bullet
                              : CupertinoIcons.square_grid_2x2,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              Expanded(
                child: _isLoading ? _buildShimmerPlaceholder() : localIsGridView
                    ? GridLayout(
                  items: currentItems,
                  onStarred: _addToStarred,
                  colorScheme: widget.colorScheme,
                  parentFolderId: widget.parentId,
                  renameFolder: _renameFolder,
                  deleteItem: _deleteFileOrFolder,
                  isTrashed: widget.isTrashed,
                  pasteFileOrFolder: pasteItem,
                  isDarkMode: widget.isDarkMode,
                )
                    : CustomListView(
                  items: currentItems,
                  onStarred: _addToStarred,
                  colorScheme: widget.colorScheme,
                  parentFolderId: widget.parentId,
                  renameFolder: _renameFolder,
                  deleteItem: _deleteFileOrFolder,
                  isTrashed: widget.isTrashed,
                  pasteFileOrFolder: pasteItem,
                  isDarkMode: widget.isDarkMode,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: FloatingActionButtonWidget(
                  onFilesAdded: _onFilesAdded,
                  isFolderUpload: false,
                  folderName: "",
                  colorScheme: widget.colorScheme,
                  parentFolderId: widget.parentId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shimmer placeholder while loading
  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor:
      CupertinoColors.systemGrey.resolveFrom(context).withOpacity(0.3),
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

  // Example method for renaming a folder (can be replaced with actual functionality)
  Future<void> _renameFolder(String newName, FileItemNew? item) async {
    setState(() {
      item!.name = newName;
    });
    // Rename functionality here...
  }

  // Example method for deleting a file or folder (can be replaced with actual functionality)
  void _deleteFileOrFolder(FileItemNew item, dynamic parentFolderId) async {
    setState(() {
      item.isDeleted = true;
    });

    // Delete functionality here...
  }

  void removeDeletedFiles(items) {
    for (var item in items) {
      if (item.isDeleted) {
        items.remove(item);
        return;
      }
      if (item.isFolder && item.children != null) {
        removeDeletedFiles(item.children!);
      }
    }
  }
}
