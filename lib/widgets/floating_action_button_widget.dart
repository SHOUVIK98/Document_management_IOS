// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import '../data/create_fileStructure.dart';
// import '../data/file_class.dart';
// import 'bottom_sheet_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class FloatingActionButtonWidget extends StatefulWidget {
//   final dynamic parentFolderId;
//   final bool isFolderUpload;
//   final String folderName;
//   final Function(List<FileItemNew>) onFilesAdded;
//   final ColorScheme colorScheme;
//   const FloatingActionButtonWidget({
//     super.key,
//     required this.folderName,
//     required this.onFilesAdded,
//     required this.isFolderUpload,
//     required this.colorScheme,
//     this.parentFolderId
//   });
//
//   @override
//   State<FloatingActionButtonWidget> createState() => _FloatingActionButtonWidgetState();
// }
//
// class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget> {
//   final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
//   String? fileName;
//   List<PlatformFile>? paths;
//   String? extension;
//   final bool multiPick = true;
//   final FileType pickingType = FileType.any;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         width: 56,
//         height: 56,
//         decoration: BoxDecoration(
//           color: widget.colorScheme.secondary,
//           shape: BoxShape.circle,
//         ),
//         child: const Center(
//           child: Icon(
//             CupertinoIcons.add,
//             color: CupertinoColors.white,
//           ),
//         ),
//       ),
//       onTap: () {
//         showCupertinoModalPopup<void>(
//           context: context,
//           builder: (BuildContext context) {
//             return BottomSheetWidget(
//               onFilesAdded: widget.onFilesAdded,
//               isFolderUpload: widget.isFolderUpload,
//               folderName: widget.folderName,
//               parentFolderId: widget.parentFolderId,
//             );
//           },
//         );
//       },
//     );
//   }
// }
// // class FloatingActionButtonWidget extends StatefulWidget{
// //   final dynamic parentFolderId;
// //   final bool isFolderUpload;
// //   final String folderName;
// //   final Function(List<FileItemNew>) onFilesAdded;
// //   final ColorScheme colorScheme;
// //   const FloatingActionButtonWidget({super.key, required this.folderName, required this.onFilesAdded, required this.isFolderUpload, required this.colorScheme, this.parentFolderId});
// //
// //   @override
// //   State<FloatingActionButtonWidget> createState() => _FloatingActionButtonWidgetState();
// // }
// //
// // class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget> {
// //   final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
// //   String? fileName;
// //   List<PlatformFile>? paths;
// //   String? extension;
// //   final bool multiPick = true;
// //   final FileType pickingType = FileType.any;
// //   @override
// //   Widget build(BuildContext context) {
// //     return FloatingActionButton(
// //       backgroundColor: widget.colorScheme.secondary,
// //       onPressed: () {
// //         showModalBottomSheet<void>(
// //           context: context,
// //           builder: (BuildContext context) {
// //             return BottomSheetWidget(onFilesAdded: widget.onFilesAdded, isFolderUpload: widget.isFolderUpload, folderName: widget.folderName, parentFolderId: widget.parentFolderId,);
// //           },
// //         );
// //       },
// //       child: const Icon(Icons.add),
// //     );
// //   }
// // }

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/create_fileStructure.dart';
import '../data/file_class.dart';
import 'bottom_sheet_widget.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  final dynamic parentFolderId;
  final bool isFolderUpload;
  final String folderName;
  final Function(List<FileItemNew>) onFilesAdded;
  final ColorScheme colorScheme; // Simple color instead of ColorScheme
  final bool? isDarkMode;

  const FloatingActionButtonWidget({
    super.key,
    required this.folderName,
    required this.onFilesAdded,
    required this.isFolderUpload,
    required this.colorScheme,
    this.parentFolderId, 
    this.isDarkMode,
  });

  @override
  State<FloatingActionButtonWidget> createState() => _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget> {
  void _showBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4, // Prevents full-screen overflow
            ),
            child: BottomSheetWidget(
              onFilesAdded: widget.onFilesAdded,
              isFolderUpload: widget.isFolderUpload,
              folderName: widget.folderName,
              parentFolderId: widget.parentFolderId,
              isDarkMode: widget.isDarkMode,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showBottomSheet,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: widget.colorScheme.secondary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.white,
          ),
        ),
      ),
    );
  }
}
