import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import '../apis/ikon_service.dart';
import '../data/create_fileStructure.dart';
import '../utils/file_upload_utils.dart';
import '../utils/snackbar_utils.dart';
import 'upload_button.dart';
import 'folder_dialog.dart';
import '../data/file_class.dart';

class UploadWidget extends StatefulWidget {
  final dynamic parentFolderId;
  final bool isFolderUpload;
  final String? folderName;
  final Function(List<FileItemNew>) onFilesAdded;

  const UploadWidget({
    super.key,
    required this.onFilesAdded,
    this.parentFolderId,
    this.isFolderUpload = false,
    this.folderName,
  });

  const UploadWidget.uploadWithinFolder({
    super.key,
    required this.onFilesAdded,
    required this.isFolderUpload,
    required this.folderName,
    this.parentFolderId,
  }) : assert(isFolderUpload, 'isFolderUpload must be true for uploadWithinFolder');

  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  final uuid = Uuid();

  Future<void> pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result == null || result.files.isEmpty) return;

      final processId = await IKonService.iKonService
          .mapProcessName(processName: "File Manager - DM");

      final fileList = processFiles(result.files, widget.isFolderUpload, widget.folderName ?? "");

      for (var file in fileList) {
        final fileSize = File(file.filePath!).lengthSync();
        final extractData = {
          "uploadResourceDetails": [
            {
              "resourceName": file.name,
              "resourceSize": fileSize,
              "resourceType": getResourceType(file.name.split('.').last),
              "resourceId": file.fileId,
              "uploadedBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
              "uploadedOn": DateTime.now().toIso8601String(),
              "fileName": file.name.split('.').first,
              "fileNameExtension": file.name.split('.').last
            }
          ],
          "resource_identifier": file.identifier,
          "folder_identifier": widget.parentFolderId,
          "createdBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
          "createdOn": DateTime.now().toIso8601String(),
          "updatedBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
          "updatedOn": DateTime.now().toIso8601String(),
          "isCreated": true,
          "userDetails": {
            "ownerFileAccess": ["b3683fff-4a28-4949-b9f0-48155df0ee59"]
          },
          "groupDetails": {},
          "extraDetails": {}
        };

        await IKonService.iKonService.uploadFile(
          filePath: file.filePath!,
          resourceId: file.fileId!,
        );

        await IKonService.iKonService.startProcessV2(
          processId: processId,
          data: extractData, processIdentifierFields: null
        );
      }

      widget.onFilesAdded(fileList);
    } catch (e) {
      showErrorSnackBar(context, 'Error: $e');
    }
  }

  void _createFolder(String folderName,dynamic parentId) async {
    final folderId = uuid.v4();
    final extractDataForFolder = {
      "folderName": folderName,
      "folder_identifier": folderId,
      "parentId": widget.parentFolderId,
      "createdBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
      "createdOn": DateTime.now().toIso8601String(),
      "updatedBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
      "updatedOn": DateTime.now().toIso8601String(),
      "type": "folder",
      "userDetails": {
        "ownerFolderAccess": ["b3683fff-4a28-4949-b9f0-48155df0ee59"]
      },
      "groupDetails": {},
      "extraDetails": {}
    };

    final processId = await IKonService.iKonService
        .mapProcessName(processName: "Folder Manager - DM");

     IKonService.iKonService.startProcessV2(
      processId: processId,
      data: extractDataForFolder,
      processIdentifierFields: "folder_identifier",
    );

    widget.onFilesAdded([
      FileItemNew(
        name: folderName,
        icon: 'assets/folder.svg',
        isFolder: true,
        isStarred: false,
        isDeleted: false,
        filePath: null,
        identifier: folderId,
      )
    ]);
  }

  @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       UploadButton(
  //         onTap: pickFiles,
  //         icon: Icons.upload_file,
  //         label: 'Upload File(s)',
  //       ),
  //       const SizedBox(width: 15),
  //       UploadButton(
  //         onTap: () {
  //           showDialog(
  //             context: context,
  //             builder: (_) => FolderDialog(onFolderCreated: _createFolder, parentId: widget.parentFolderId),
  //           );
  //         },
  //         icon: Icons.folder_open,
  //         label: 'Create Folder',
  //       ),
  //     ],
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UploadButton(
          onTap: pickFiles,
          icon: Icons.upload_file,
          label: 'Upload File(s)',
        ),
        const SizedBox(width: 15),
        UploadButton(
          onTap: () {
            showCupertinoDialog(
              context: context,
              builder: (_) => FolderDialog(
                onFolderCreated: _createFolder,
                parentId: widget.parentFolderId,
              ),
            );
          },
          icon: Icons.folder_open,
          label: 'Create Folder',
        ),
      ],
    );
  }
}

// class UploadWidget extends StatefulWidget {
//   final dynamic parentFolderId;
//   final bool isFolderUpload;
//   final String? folderName;
//   final Function(List<FileItemNew>) onFilesAdded;
//
//   const UploadWidget({
//     super.key,
//     required this.onFilesAdded,
//     this.parentFolderId
//   }) : isFolderUpload = false,
//         folderName = null;
//
//   const UploadWidget.uploadWithinFolder({
//     super.key,
//     required this.onFilesAdded,
//     required this.isFolderUpload,
//     required this.folderName,
//     this.parentFolderId
//   }) : assert(isFolderUpload == true, 'isFolderUpload must be true for uploadWithinFolder');
//
//   @override
//   _UploadWidgetState createState() => _UploadWidgetState();
// }
//
// class _UploadWidgetState extends State<UploadWidget> {
//   var uuid = Uuid();
//
//   Future<void> pickFiles(bool isFolderUpload, String folderName, dynamic parentFolderId) async {
//     try {
//       final result = await FilePicker.platform.pickFiles(
//         compressionQuality: 30,
//         type: FileType.any,
//         allowMultiple: true,
//         onFileLoading: (FilePickerStatus status) => print(status),
//       );
//       String processId = await IKonService.iKonService
//           .mapProcessName(processName: "File Manager - DM");
//       if (result != null && result.files.isNotEmpty) {
//         List<FileItemNew> fileList =
//         processFiles(result.files, isFolderUpload, folderName);
//
//         fileList.asMap().entries.map((entry) {
//           final index = entry.key;
//           final file = entry.value;
//
//           print('Processing file at index: $index, File: ${file.name}');
//
//           final fileSize = File(file.filePath!).lengthSync();
//           final Map<String, dynamic> extractData = {
//             "uploadResourceDetails": [
//               {
//                 "resourceName": file.name,
//                 "resourceSize": fileSize,
//                 "resourceType": getResourceType(result.files[index].extension!),
//                 "resourceId": file.fileId,
//                 "uploadedBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
//                 "uploadedOn": DateTime.now().toIso8601String(),
//                 "fileName": file.name.split('.').first,
//                 "fileNameExtension": result.files[index].extension! ?? 'unknown'
//               }
//             ],
//             "resource_identifier": file.identifier,
//             "folder_identifier": parentFolderId,
//             "createdBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
//             "createdOn": DateTime.now().toIso8601String(),
//             "updatedBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
//             "updatedOn": DateTime.now().toIso8601String(),
//             "isCreated": true,
//             "userDetails": {
//               "folderViewUserAccess": [],
//               "removedFileUserAccess": [],
//               "folderEditUserAccess": [],
//               "editFileUserAccess": [],
//               "folderOwnerUserAccess": [],
//               "viewFileUserAccess": [],
//               "ownerFileAccess": ["b3683fff-4a28-4949-b9f0-48155df0ee59"]
//             },
//             "groupDetails": {
//               "folderViewGrpAccess": [],
//               "removedFileGrpAccess": [],
//               "editFileGrpAccess": [],
//               "ownerFileGrpAccess": [],
//               "folderOwnerGrpAccess": [],
//               "viewFileGrpAccess": [],
//               "folderEditGrpAccess": []
//             },
//             "extraDetails": {}
//           };
//
//           print('Extract data for file: ${file.name} - $extractData');
//
//
//           Future<String> resourceId = IKonService.iKonService.uploadFile(filePath: file.filePath!, resourceId: file.fileId!);
//           IKonService.iKonService.startProcessV2(
//               processId: processId,
//               data: extractData,
//               processIdentifierFields: null);
//         }).toList();
//
//         widget.onFilesAdded(fileList);
//         // widget.onFilesAdded(processFiles(result.files, isFolderUpload, folderName));
//       }
//     } catch (e) {
//       print('Error: $e');
//       showErrorSnackBar(context, 'Error: $e');
//     }
//   }
//
//   Future<void> _createFolder(String folderName, dynamic parentId) async {
//     final String folderId = uuid.v4();
//     final Map<String, dynamic> extractDataForFolder = {
//       "folderName": folderName,
//       "folder_identifier": folderId,
//       "parentId": parentId,
//       "createdBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
//       "createdOn": "2025-01-16T09:40:53.158+0000",
//       "updatedBy": "b3683fff-4a28-4949-b9f0-48155df0ee59",
//       "updatedOn": "2025-01-16T09:40:53.159+0000",
//       "type": "folder",
//       "userDetails": {
//         "editFolderAccess": [],
//         "viewFolderAccess": [],
//         "ownerFolderAccess": ["b3683fff-4a28-4949-b9f0-48155df0ee59"],
//         "removedUserFolderAccess": [],
//         "parentEditFolderAccess": [],
//         "parentViewFolderAccess": [],
//         "parentOwnerFolderAccess": []
//       },
//       "groupDetails": {
//         "editFolderGrpAccess": [],
//         "viewFolderGrpAccess": [],
//         "ownerFolderGrpAccess": [],
//         "removedFolderGrpAccess": [],
//         "parentEditFolderGrpAccess": [],
//         "parentViewFolderGrpAccess": [],
//         "parentOwnerFolderGrpAccess": []
//       },
//       "extraDetails": {}
//     };
//
//     String processId = await IKonService.iKonService
//         .mapProcessName(processName: "Folder Manager - DM");
//
//     await IKonService.iKonService.startProcessV2(
//         processId: processId,
//         data: extractDataForFolder,
//         processIdentifierFields: "folder_identifier");
//     final newFolder = FileItemNew(
//       name: folderName,
//       icon: 'assets/folder.svg',
//       isFolder: true,
//       isStarred: false,
//       isDeleted: false,
//       filePath: null,
//       identifier: folderId,
//     );
//
//     widget.onFilesAdded([newFolder]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         UploadButton(
//           onTap:(){
//            // pickFiles(widget.isFolderUpload, widget.folderName?? "", widget.parentFolderId);
//             // Navigator.pop(context);
//           },
//           icon: Icons.upload_file,
//           label: 'Upload File(s)',
//         ),
//         const SizedBox(width: 15),
//         UploadButton(
//           onTap: () {
//             showDialog(
//               context: context,
//               builder: (_) => FolderDialog(onFolderCreated: _createFolder, parentId: widget.parentFolderId,),
//             );
//             // Navigator.pop(context);
//           },
//           icon: Icons.folder_open,
//           label: 'Create Folder',
//         ),
//       ],
//     );
//   }
// }