// import 'package:flutter/material.dart';
// import '../data/create_fileStructure.dart';
// import '../data/file_class.dart';
// import 'upload_widget.dart';
// import 'package:flutter/cupertino.dart';
//
//
// class BottomSheetWidget extends StatelessWidget {
//   final dynamic parentFolderId;
//   final Function(List<FileItemNew>) onFilesAdded;
//   final bool isFolderUpload;
//   final String folderName;
//
//   const BottomSheetWidget({
//     super.key,
//     required this.folderName,
//     required this.onFilesAdded,
//     required this.isFolderUpload,
//     this.parentFolderId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPopupSurface(
//       // This gives a nice "cupped" look with rounded edges
//       isSurfacePainted: true,
//       child: Container(
//         height: 200,
//         decoration: const BoxDecoration(
//           color: CupertinoColors.systemBackground,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(12),
//             topRight: Radius.circular(12),
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               isFolderUpload
//                   ? UploadWidget.uploadWithinFolder(
//                 onFilesAdded: onFilesAdded,
//                 isFolderUpload: isFolderUpload,
//                 folderName: folderName,
//                 parentFolderId: parentFolderId,
//               )
//                   : UploadWidget(
//                 onFilesAdded: onFilesAdded,
//                 parentFolderId: parentFolderId,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // class BottomSheetWidget extends StatelessWidget {
// //   final dynamic parentFolderId;
// //   final Function(List<FileItemNew>) onFilesAdded;
// //   final bool isFolderUpload;
// //   final String folderName;
// //   const BottomSheetWidget({super.key, required this.folderName, required this.onFilesAdded, required this.isFolderUpload, this.parentFolderId
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 200,
// //       decoration: const BoxDecoration(
// //         color: CupertinoColors.systemBackground,
// //         borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(12),
// //           topRight: Radius.circular(12),
// //         ),
// //       ),
// //       child: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           mainAxisSize: MainAxisSize.min,
// //           children: <Widget>[
// //             isFolderUpload
// //                 ? UploadWidget.uploadWithinFolder(
// //               onFilesAdded: onFilesAdded,
// //               isFolderUpload: isFolderUpload,
// //               folderName: folderName,
// //               parentFolderId: parentFolderId,
// //             )
// //                 : UploadWidget(
// //               onFilesAdded: onFilesAdded,
// //               parentFolderId: parentFolderId,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // class BottomSheetWidget extends StatelessWidget {
// //   final dynamic parentFolderId;
// //   final Function(List<FileItemNew>) onFilesAdded;
// //   final bool isFolderUpload;
// //   final String folderName;
// //   const BottomSheetWidget({super.key, required this.folderName, required this.onFilesAdded, required this.isFolderUpload, this.parentFolderId});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 200,
// //       child: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           mainAxisSize: MainAxisSize.min,
// //           children: <Widget>[
// //             isFolderUpload? UploadWidget.uploadWithinFolder(onFilesAdded: onFilesAdded, isFolderUpload: isFolderUpload, folderName: folderName, parentFolderId: parentFolderId,): UploadWidget(onFilesAdded: onFilesAdded, parentFolderId: parentFolderId,),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
import 'package:flutter/cupertino.dart';
import '../data/create_fileStructure.dart';
import '../data/file_class.dart';
import 'upload_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  final dynamic parentFolderId;
  final Function(List<FileItemNew>) onFilesAdded;
  final bool isFolderUpload;
  final String folderName;

  const BottomSheetWidget({
    super.key,
    required this.folderName,
    required this.onFilesAdded,
    required this.isFolderUpload,
    this.parentFolderId,
  });

  @override
  Widget build(BuildContext context) {
    return  CupertinoPopupSurface(
        isSurfacePainted: true,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4, // Ensures bottom sheet height is constrained
            // maxHeight: 250,
          ),
          decoration: const BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: SingleChildScrollView(
             // Prevents vertical overflow
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevents unnecessary height expansion
              children: <Widget>[
                isFolderUpload
                    ? UploadWidget.uploadWithinFolder(
                  onFilesAdded: onFilesAdded,
                  isFolderUpload: isFolderUpload,
                  folderName: folderName,
                  parentFolderId: parentFolderId,
                )
                    : UploadWidget(
                  onFilesAdded: onFilesAdded,
                  parentFolderId: parentFolderId,
                ),
                const SizedBox(height: 20), // Adds spacing at the bottom
                CupertinoButton(
                  child: const Text("Close"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
