// import 'package:flutter/material.dart';
// // import 'package:document_management_main/data/item_data.dart';
// import 'package:flutter_svg/svg.dart';
// import '../data/create_fileStructure.dart';
// import '../data/file_class.dart';
// import '../files_viewer/image_viewer_page.dart';
// import '../files_viewer/pdf_viewer_page.dart';
// import '../files_viewer/text_viewer_page.dart';
// import '../widgets/bottom_modal_options.dart';
// import '../widgets/folder_screen_widget.dart';

// class CustomListView extends StatelessWidget {
//   final List<FileItemNew> items;
//   final Function(FileItemNew)? onStarred;
//   final ColorScheme colorScheme;
//   final Function(String, FileItemNew item)? renameFolder;
//   final Function(FileItemNew item, dynamic parentFolderId)? deleteItem;
//   final bool isTrashed;
//   final dynamic parentFolderId;

//   const CustomListView({super.key, required this.items, this.onStarred, required this.colorScheme, this.renameFolder, this.deleteItem, this.isTrashed = false, this.parentFolderId});

//   @override
//   Widget build(BuildContext context) {
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     // print("islight $isLight");
//     return ListView.builder(
//         padding: const EdgeInsets.all(8),
//         itemCount: items.length,
//         itemBuilder: (BuildContext context, int index) {
//           final item = items[index];
//           String itemName = item.name.toString();
//           itemName = itemName.length > 20 ? '${itemName.substring(0, 20)}...' : itemName;

//           return Padding(
//             padding: const EdgeInsets.only(left:10.0),
//             child: ListTile(
//               leading: SvgPicture.asset(
//                 item.icon,
//                 height: 20.0,
//                 width: 20.0,
//               ),
//               title: Text(
//                 // item.name,
//                 itemName,
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.w500,
//                   color: colorScheme.primary,
//                 ),
//               ),
//               onTap: () {
//                 // print("Item tapped: ${item.name}");
//                 //OpenFile.open(item.filePath);
//                 if (item.isFolder) {
//                   Navigator.of(context).push(PageRouteBuilder(
//                     pageBuilder: (context, animation, secondaryAnimation) =>
//                         FolderScreenWidget(
//                       fileItems: item.children ?? [],
//                       folderName: item.name,
//                       colorScheme: colorScheme,
//                        parentId: item.identifier,
//                        isTrashed: isTrashed ? true : false,
//                       // isLightTheme: isLightTheme,
//                     ),
//                     transitionsBuilder:
//                         (context, animation, secondaryAnimation, child) {
//                       const begin = Offset(1.0, 0.0); // Start from the right
//                       const end = Offset.zero; // End at the original position
//                       const curve = Curves.easeInOut;

//                       var tween = Tween(begin: begin, end: end)
//                           .chain(CurveTween(curve: curve));
//                       var offsetAnimation = animation.drive(tween);

//                       return SlideTransition(
//                           position: offsetAnimation, child: child);
//                     },
//                   ));
//                 } else if (item.filePath!.endsWith("pdf")) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             PdfViewerPage(filePath: item.filePath!, fileName: item.name,)),
//                   );
//                 } else if (item.filePath!.endsWith("plain")) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             TextFileViewerPage(filePath: item.filePath!,fileName: item.name,)),
//                   );
//                 } else if (item.filePath!.endsWith("png") ||
//                     item.filePath!.endsWith("jpg")) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             ImageViewerPage(imagePath: item.filePath!,fileName: item.name,)),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Unsupported file type")),
//                   );
//                 }
//               },
//               subtitle: Row(
//                 children: [
//                   if (item.isStarred)
//                     Icon(
//                       Icons.star,
//                       color: colorScheme.secondary,
//                       size: 18.0,
//                     ),
//                   const SizedBox(
//                     width: 5.0,
//                   ),
//                   Text(
//                     "Opened Recently",
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: colorScheme.secondary
//                     ),
//                   ),
//                 ],
//               ),
//               trailing: IconButton(
//                 icon: Icon(
//                   Icons.more_vert,
//                   size: 24.0,
//                   // color: isLight ? Colors.black : Colors.white,
//                   color: colorScheme.secondary,
//                 ),
//                 onPressed: () {
//                   // Handle three dots button press
//                   // print("Three dots button pressed for item: ${item.name}");
//                   showModalBottomSheet(
//                     context: context,
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(16.0),
//                         topRight: Radius.circular(16.0),
//                       ),
//                     ),
//                     builder: (BuildContext context) {
//                       return isTrashed! ? BottomModalOptions(item, isTrashed: isTrashed,) : BottomModalOptions(item, onStarred: onStarred, renameFolder: renameFolder, deleteItem : deleteItem, isTrashed: isTrashed,parentFolderId: parentFolderId);
//                     },
//                   );
//                 },
//               ),
//             ),
//           );
//           // return Container(
//           //   height: 50,
//           //   child: Row(
//           //     children: [
//           //       SvgPicture.asset(
//           //         items[index].icon,
//           //         height: 20.0,
//           //         width: 20.0,
//           //       ),
//           //       const SizedBox(
//           //         width: 10.0,
//           //       ),
//           //       Text(
//           //         items[index].name,
//           //         style: const TextStyle(
//           //           fontSize: 17.0,
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // );
//         });
//   }
// }

// IOS CODE
import 'package:document_management_main/utils/show_bottom_modal_options_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        ColorScheme,
        Curves,
        Offset,
        PageRouteBuilder,
        Theme,
        showModalBottomSheet; // We might keep this if the bottom sheet is still material-based
import 'package:flutter_svg/flutter_svg.dart';

import '../data/create_fileStructure.dart';
import '../data/file_class.dart';
import '../files_viewer/image_viewer_page.dart';
import '../files_viewer/pdf_viewer_page.dart';
import '../files_viewer/text_viewer_page.dart';
import '../widgets/bottom_modal_options.dart';
import '../widgets/folder_screen_widget.dart';

class CustomListView extends StatelessWidget {
  final List<FileItemNew> items;
  final Function(FileItemNew)? onStarred;
  final ColorScheme colorScheme;
  final Function(String, FileItemNew item)? renameFolder;
  final Function(FileItemNew item, dynamic parentFolderId)? deleteItem;
  final bool isTrashed;
  final dynamic parentFolderId;
  final Function? pasteFileOrFolder;
  final Function? homeRefreshData;
  final bool? isDarkMode;

  const CustomListView({
    super.key,
    required this.items,
    this.onStarred,
    required this.colorScheme,
    this.renameFolder,
    this.deleteItem,
    this.isTrashed = false,
    this.parentFolderId,
    this.pasteFileOrFolder,
    this.homeRefreshData,
    this.isDarkMode
  });

  @override
  Widget build(BuildContext context) {
    // For example, to check brightness:
    final isLight = Theme.of(context).brightness == Brightness.light;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        // Truncate item name for display
        String itemName = item.name;
        if (itemName.length > 20) {
          itemName = '${itemName.substring(0, 20)}...';
        }

        // Build an iOS-style row:
        return Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CupertinoButton(
            // Remove default padding for a more "list-like" feel:
            padding: EdgeInsets.zero,
            onPressed: () => _handleItemTap(context, item),
            onLongPress: () => showOptions(
                context,
                item,
                onStarred,
                renameFolder,
                deleteItem,
                isTrashed,
                parentFolderId,
                pasteFileOrFolder,
                homeRefreshData,
                colorScheme,
                isDarkMode!),
            child: Row(
              children: [
                // Leading icon
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SvgPicture.asset(
                    item.icon,
                    height: 24.0,
                    width: 24.0,
                  ),
                ),

                // Text Column (Title + Subtitle)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        itemName,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Subtitle row (star icon + "Opened Recently")
                      Row(
                        children: [
                          if (item.isStarred)
                            Icon(
                              CupertinoIcons.star_fill,
                              color: colorScheme.secondary,
                              size: 16.0,
                            ),
                          if (item.isStarred) const SizedBox(width: 5),
                          Text(
                            "Opened Recently",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Trailing options (the "3 dots")
                // CupertinoButton(
                //   padding: const EdgeInsets.all(8.0),
                //   onPressed: () => _showOptions(context, item),
                //   child: Icon(
                //     CupertinoIcons.ellipsis_vertical,
                //     color: colorScheme.secondary,
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Handle tapping on the list item itself
  void _handleItemTap(BuildContext context, FileItemNew item) {
    // If it’s a folder, navigate to the FolderScreenWidget
    if (item.isFolder) {
      Navigator.of(context).push(
        PageRouteBuilder(
          // For an iOS-like transition, you could use CupertinoPageRoute,
          // but we'll keep a custom SlideTransition for demonstration:
          pageBuilder: (context, animation, secondaryAnimation) =>
              FolderScreenWidget(
            fileItems: item.children ?? [],
            folderName: item.name,
            colorScheme: colorScheme,
            parentId: item.identifier,
            isTrashed: isTrashed,
            folderId: item.identifier,
            homeRefreshData: homeRefreshData,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Start offscreen to the right
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    }
    // If it’s a file, open the correct viewer
    else if (item.filePath != null) {
      final path = item.filePath!.toLowerCase();
      if (path.endsWith("pdf")) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PdfViewerPage(
              filePath: item.filePath!,
              fileName: item.name,
            ),
          ),
        );
      } else if (path.endsWith("plain") || path.endsWith(".txt")) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TextFileViewerPage(
              filePath: item.filePath!,
              fileName: item.name,
            ),
          ),
        );
      } else if (path.endsWith("png") || path.endsWith("jpg")) {
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
        // Show Cupertino dialog for unsupported type
        _showUnsupportedFileDialog(context);
      }
    } else {
      _showUnsupportedFileDialog(context, message: "No file path found");
    }
  }

  /// Show iOS-style alert for unsupported file
  void _showUnsupportedFileDialog(BuildContext context, {String? message}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: const Text("Unsupported file"),
          content: Text(message ?? "Unsupported file type"),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        );
      },
    );
  }

  /// Show iOS-style bottom popup (instead of Material bottom sheet)
  // void _showOptions(BuildContext context, FileItemNew item) {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext ctx) {
  //       // If you want to keep your existing Material bottom sheet design,
  //       // you can wrap it in a CupertinoPopupSurface or use a CupertinoActionSheet.
  //       // For simplicity, let's just embed your existing bottom sheet widget:
  //       return BottomModalOptions(
  //         item,
  //         onStarred: onStarred,
  //         renameFolder: renameFolder,
  //         deleteItem: deleteItem,
  //         isTrashed: isTrashed,
  //         parentFolderId: parentFolderId,
  //       );
  //     },
  //   );
  // }
}
