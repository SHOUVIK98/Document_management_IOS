// import 'package:document_management_main/data/file_class.dart';
// import 'package:flutter/material.dart';

// import '../apis/ikon_service.dart';
// import '../data/create_fileStructure.dart';
// import '../fragments/home_fragment.dart';
// import '../utils/cut_copy_paste_utils.dart';
// import 'folder_dialog.dart';

// class BottomModalOptions extends StatelessWidget {
//   final FileItemNew itemData;
//   final Function(FileItemNew)? onStarred;
//   final Function(String, FileItemNew item)? renameFolder;
//   final Function(FileItemNew item, dynamic parentFolderId)? deleteItem;
//   final bool? isTrashed;
//   final dynamic parentFolderId;


//   const BottomModalOptions(this.itemData, {this.onStarred, super.key, this.renameFolder, this.deleteItem, this.isTrashed, this.parentFolderId});

//   @override
//   Widget build(BuildContext context) {
//     String cutOrCopiedIdentifier=" ";
//     String cutOrCopied;
//     String folderOrFile;
//     bool isCutOrCopied=false;
//     String taskId;
//     final isLightTheme = Theme.of(context).brightness == Brightness.light;

//     Future<void> _renameFolderServer(String newName) async {
//       String identifier=itemData.identifier;
//       print("Rename folder called");
//       itemData.name = newName;

//       final List<Map<String, dynamic>> folderInstanceData =
//           await IKonService.iKonService.getMyInstancesV2(
//         processName: "Folder Manager - DM",
//         predefinedFilters: {"taskName": "Editor Access"},
//         processVariableFilters: {"folder_identifier" : identifier},
//         taskVariableFilters: null,
//         mongoWhereClause: null,
//         projections: ["Data"],
//         allInstance: false,
//       );

//       print("Task id:");

//       print(folderInstanceData[0]["taskId"]);
//       taskId= folderInstanceData[0]["taskId"];

//       bool result =  await IKonService.iKonService.invokeAction(taskId: taskId,transitionName: "Update Editor Access",data: {"folder_identifier":itemData.identifier,"folderName":itemData.name}, processIdentifierFields: null);


//     }

//     void _cutOrCopyDocument(isFolder,cutOrCopied,identifier){
//       String copied_identifier,item_type;
//         if(isFolder){
//           item_type="folder";
//           copied_identifier=identifier;
//         }
//         else{
//           item_type="file";
//           copied_identifier=identifier;
//         }
//       cutOrCopiedIdentifier=copied_identifier;
//       cutOrCopied=cutOrCopied;
//       folderOrFile=item_type;
//       isCutOrCopied=true;
//     }

//     // Future<void> _pasteFolder(String destinationIdentifier) async {
//     //   print(cutOrCopiedIdentifier);
//     //   final List<Map<String, dynamic>> folderInstanceData =
//     //       await IKonService.iKonService.getMyInstancesV2(
//     //     processName: "Folder Manager - DM",
//     //     predefinedFilters: {"taskName": "Sharing Activity"},
//     //     processVariableFilters: {"folder_identifier" : cutOrCopiedIdentifier!},
//     //     taskVariableFilters: null,
//     //     mongoWhereClause: null,
//     //     projections: ["Data"],
//     //     allInstance: false,
//     //   );
//     //   print(folderInstanceData);
//     // }

//     return Container(
//       decoration: BoxDecoration(
//         color: isLightTheme ? Colors.white : Colors.black,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(16.0),
//           topRight: Radius.circular(16.0),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Handle bar for visual cue
//           Container(
//             width: 40.0,
//             height: 5.0,
//             margin: const EdgeInsets.symmetric(vertical: 8.0),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//           ),
//           // Options
//           Text(
//             itemData.name,
//             style: const TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 10.0),

//           ListView(
//             shrinkWrap: true,
//             children: (isTrashed != null && isTrashed == true) ? 
//             [
//                     _buildOption(
//                       context,
//                       icon: Icons.delete_forever,
//                       label: "Delete Permanently",
//                       onTap: () {
//                         // Handle delete permanently action
//                       },
//                     ),
//                     _buildOption(
//                       context,
//                       icon: Icons.restore,
//                       label: "Restore",
//                       onTap: () {
//                         // Handle restore action
//                       },
//                     ),
//                   ] : 
//             [
//               if (itemData.isFolder)
//                 _buildOption(
//                   context,
//                   icon: Icons.drive_file_rename_outline,
//                   label: "Rename",
//                   onTap: () async {
//                     showDialog(
//                       context: context,
//                       builder: (_) => FolderDialog(
//                         // onFolderCreated: renameFolder,
//                         folderData: itemData,
//                         renameFolder: renameFolder,
//                        // onFolderCreated: _renameFolderServer,
//                       ),
//                     );
//                     Navigator.pop(context); // Close the modal
//                     print("Rename option selected");
//                   },
//                 ),
//               _buildOption(
//                 context,
//                 icon: Icons.home_outlined,
//                 label: "Move to Home",
//                 onTap: () {
//                   Navigator.pop(context); // Close the modal
//                   bool isFolder = itemData.isFolder;
//                   String cutOrCopied = "cut";
//                   String identifier = itemData.identifier;
//                   cutOrCopyDocument(
//                       isFolder, cutOrCopied, identifier, itemData);
//                   pasteDocument("home", context);
//                 },
//               ),
//               _buildOption(
//                 context,
//                 icon: Icons.cut,
//                 label: "Cut",
//                 onTap: () {
//                   Navigator.pop(context); // Close the modal
//                   bool isFolder = itemData.isFolder;
//                   String cutOrCopied = "cut";
//                   String identifier = itemData.identifier;
//                   // _cutOrCopyDocument(isFolder, cutOrCopied, identifier);
//                   cutOrCopyDocument(
//                       isFolder, cutOrCopied, identifier, itemData);
//                 },
//               ),
//               _buildOption(
//                 context,
//                 icon: Icons.copy,
//                 label: "Copy",
//                 onTap: () {
//                   Navigator.pop(context); // Close the modal
//                   bool isFolder = itemData.isFolder;
//                   String cutOrCopied = "copy";
//                   String identifier = itemData.identifier;
//                   // _cutOrCopyDocument(isFolder, cutOrCopied, identifier);
//                   cutOrCopyDocument(
//                       isFolder, cutOrCopied, identifier, itemData);
//                 },
//               ),
//               _buildOption(
//                 context,
//                 icon: Icons.paste,
//                 label: "Paste",
//                 onTap: () {
//                   Navigator.pop(context); // Close the modal
//                   if (itemData.isFolder) {
//                     String destinationIdentifier = itemData.identifier;
//                     // _pasteFolder(destinationIdentifier);
//                     pasteDocument(
//                         destinationItem: itemData,
//                         destinationIdentifier,
//                         context);
//                   }
//                   print("Share option selected");
//                 },
//               ),

//               _buildOption(
//                 context,
//                 icon: itemData.isStarred ? Icons.star : Icons.star_border,
//                 label: itemData.isStarred
//                     ? "Remove from Starred"
//                     : "Add to Starred",
//                 onTap: () {
//                   // itemData.isStarred = true;
//                   if (onStarred != null) {
//                     onStarred!(itemData);
//                   }
//                   Navigator.pop(context); // Close the modal
//                   print("Add to Starred option selected");
//                 },
//               ),
//               _buildOption(
//                 context,
//                 icon: Icons.delete_outline,
//                 label: "Move to Trash",
//                 onTap: () {
//                   Navigator.pop(context); // Close the modal
//                   deleteItem!(itemData, parentFolderId);
//                   print("Share option selected");
//                 },
//               ),
//             ]
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOption(BuildContext context,
//       {required IconData icon,
//       required String label,
//       required VoidCallback onTap}) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.grey.shade700),
//       title: Text(
//         label,
//         style: const TextStyle(
//           fontSize: 16.0,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }












// IOS LOOK AND FEEL CODE:

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:document_management_main/data/file_class.dart';

import '../apis/ikon_service.dart';
import '../data/create_fileStructure.dart';
import '../fragments/home_fragment.dart';
import '../utils/cut_copy_paste_utils.dart';
import 'folder_dialog.dart';

class BottomModalOptions extends StatelessWidget {
  final FileItemNew itemData;
  final Function(FileItemNew)? onStarred;
  final Function(String, FileItemNew item)? renameFolder;
  final Function(FileItemNew item, dynamic parentFolderId)? deleteItem;
  final bool? isTrashed;
  final dynamic parentFolderId;

  const BottomModalOptions(
    this.itemData, {
    this.onStarred,
    super.key,
    this.renameFolder,
    this.deleteItem,
    this.isTrashed,
    this.parentFolderId,
  });

  @override
  Widget build(BuildContext context) {
    String cutOrCopiedIdentifier = " ";
    String cutOrCopied;
    String folderOrFile;
    bool isCutOrCopied = false;
    String taskId;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    Future<void> _renameFolderServer(String newName) async {
      String identifier = itemData.identifier;
      print("Rename folder called");
      itemData.name = newName;

      final List<Map<String, dynamic>> folderInstanceData =
          await IKonService.iKonService.getMyInstancesV2(
        processName: "Folder Manager - DM",
        predefinedFilters: {"taskName": "Editor Access"},
        processVariableFilters: {"folder_identifier": identifier},
        taskVariableFilters: null,
        mongoWhereClause: null,
        projections: ["Data"],
        allInstance: false,
      );

      print("Task id:");

      print(folderInstanceData[0]["taskId"]);
      taskId = folderInstanceData[0]["taskId"];

       bool result =  await IKonService.iKonService.invokeAction(taskId: taskId,transitionName: "Update Editor Access",data: {"folder_identifier":itemData.identifier,"folderName":itemData.name}, processIdentifierFields: null);
    }

    void _cutOrCopyDocument(isFolder, cutOrCopied, identifier) {
      String copied_identifier, item_type;
      if (isFolder) {
        item_type = "folder";
        copied_identifier = identifier;
      } else {
        item_type = "file";
        copied_identifier = identifier;
      }
      cutOrCopiedIdentifier = copied_identifier;
      cutOrCopied = cutOrCopied;
      folderOrFile = item_type;
      isCutOrCopied = true;
    }

    return CupertinoActionSheet(
      title: Text(
        itemData.name,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: Container(
        height: 400,
        child: ListView(
          children: (isTrashed != null && isTrashed == true)
              ? [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      // Handle delete permanently action
                    },
                    child: const Text("Delete Permanently"),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      // Handle restore action
                    },
                    child: const Text("Restore"),
                  ),
                ]
              : [
                  if (itemData.isFolder)
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (_) => FolderDialog(
                            folderData: itemData,
                            renameFolder: renameFolder,
                          ),
                        );
                        Navigator.pop(context);
                        print("Rename option selected");
                      },
                      child: const Text("Rename"),
                    ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                      bool isFolder = itemData.isFolder;
                      String cutOrCopied = "cut";
                      String identifier = itemData.identifier;
                      _cutOrCopyDocument(isFolder, cutOrCopied, identifier);
                      pasteDocument("home", context);
                    },
                    child: const Text("Move to Home"),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                      bool isFolder = itemData.isFolder;
                      String cutOrCopied = "cut";
                      String identifier = itemData.identifier;
                      _cutOrCopyDocument(isFolder, cutOrCopied, identifier);
                    },
                    child: const Text("Cut"),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                      bool isFolder = itemData.isFolder;
                      String cutOrCopied = "copy";
                      String identifier = itemData.identifier;
                      _cutOrCopyDocument(isFolder, cutOrCopied, identifier);
                    },
                    child: const Text("Copy"),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                      if (itemData.isFolder) {
                        String destinationIdentifier = itemData.identifier;
                        pasteDocument(
                          destinationItem: itemData,
                          destinationIdentifier,
                          context,
                        );
                      }
                      print("Share option selected");
                    },
                    child: const Text("Paste"),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      if (onStarred != null) {
                        onStarred!(itemData);
                      }
                      Navigator.pop(context); // Close the modal
                      print("Add to Starred option selected");
                    },
                    child: Text(itemData.isStarred
                        ? "Remove from Starred"
                        : "Add to Starred"),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                      deleteItem!(itemData, parentFolderId);
                      print("Delete option selected");
                    },
                    child: const Text("Move to Trash"),
                  ),
                ],
        ),
      ),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("Close"),
      ),
    );
  }
}
