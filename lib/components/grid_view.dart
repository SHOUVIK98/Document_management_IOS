import 'package:document_management_main/data/file_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:document_management_main/widgets/folder_screen_widget.dart';
import 'package:document_management_main/utils/show_bottom_modal_options_util.dart';
import '../data/create_fileStructure.dart';
import '../files_viewer/image_viewer_page.dart';
import '../files_viewer/pdf_viewer_page.dart';
import '../files_viewer/text_viewer_page.dart';
import '../widgets/bottom_modal_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class GridLayout extends StatelessWidget {
  final List<FileItemNew> items;
  final ColorScheme colorScheme;
  final Function(FileItemNew)? onStarred;
  final Function(String, FileItemNew item)? renameFolder;
  final Function(FileItemNew item, dynamic parentFolderId)? deleteItem;
  final bool isTrashed;
  final dynamic parentFolderId;
  final Function? pasteFileOrFolder;
  final Function? homeRefreshData;
  final bool? isDarkMode;
  // final bool isLightTheme;
  /*
  * onStarred: onStarred,
          renameFolder: renameFolder,
          deleteItem: deleteItem,
          isTrashed: isTrashed,
          parentFolderId: parentFolderId,
  * */
  const GridLayout(
      {super.key,
      required this.items,
      this.onStarred,
      required this.colorScheme,
      this.renameFolder,
      this.deleteItem,
      this.isTrashed = false,
      this.parentFolderId, 
      this.pasteFileOrFolder, 
      this.homeRefreshData,
      this.isDarkMode});

  // @override
  // Widget build(BuildContext context) {
  //   final isLight = Theme.of(context).brightness == Brightness.light;
  //   // print("islight $isLight");
  //
  //   return GridView.builder(
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 3,
  //       crossAxisSpacing: 0.0,
  //       mainAxisSpacing: 0.0,
  //       childAspectRatio: 0.5,
  //     ),
  //     itemCount: items.length,
  //     itemBuilder: (context, index) {
  //       final item = items[index];
  //       return _buildGridLayout(item, context, isLight);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Localizations(
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale('en', 'US'),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 1.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildGridLayout(item, context, isLight);
        },
      ),
    );
  }


  Widget _buildGridLayout(dynamic item, BuildContext context, bool isLight) {
    String itemName = item.name.toString();
    itemName =
        itemName.length > 10 ? itemName.substring(0, 10) + '...' : itemName;

    return GestureDetector(
      onLongPress: (){
        showOptions(context, item, onStarred, renameFolder, deleteItem, isTrashed, parentFolderId,pasteFileOrFolder,homeRefreshData, colorScheme, isDarkMode!);
      },
      onTap: () {
        String fileName = item.name;
        print("Item tapped: ${item.name}");
        //OpenFile.open(item.filePath);
        if (item.isFolder) {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FolderScreenWidget(
              fileItems: item.children ?? [],
              folderName: item.name,
              colorScheme: colorScheme,
              parentId: item.identifier,
              folderId: item.identifier,
              isTrashed: isTrashed ? true : false,
              homeRefreshData:homeRefreshData,

              // isLightTheme: isLightTheme,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Start from the right
              const end = Offset.zero; // End at the original position
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ));
        } else if (item.filePath.endsWith("pdf")) {
          Navigator.push(
            context,
            // Access the file name
            MaterialPageRoute(
                builder: (context) =>
                    PdfViewerPage(filePath: item.filePath, fileName: fileName)),
          );
        } else if (item.filePath.endsWith("plain")) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TextFileViewerPage(
                    filePath: item.filePath, fileName: fileName)),
          );
        } else if (item.filePath.endsWith("png") ||
            item.filePath.endsWith("jpg")) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageViewerPage(
                    imagePath: item.filePath, fileName: fileName)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Unsupported file type")),
          );
        }
      },
      onDoubleTap: () {
        // Handle item double tap
        print("Item double tapped: ${item.name}");
      },
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: Colors.white,
        //     width: 1.0,
        //   ),
        //   // borderRadius: BorderRadius.circular(10.0),
        //   // color: item.isFolder ? Colors.blue.shade50 : Colors.grey.shade200,
        // ),
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                SvgPicture.asset(
                  item.icon,
                  height: 70.0,
                  width: 90.0,
                ),
                const SizedBox(height: 4.0),
                Text(
                  itemName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            if (item.isStarred)
              Positioned(
                bottom: 0.0,
                right: 8.0,
                child: Icon(
                  Icons.star,
                  color: colorScheme.secondary,
                  size: 18.0,
                ),
              ),
            // Positioned(
            //   top: 0.0,
            //   right: 0.0,
            //   left: 125,
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.more_vert,
            //       size: 24.0,
            //       color: colorScheme.secondary,
            //     ),
            //     onPressed: () {
            //       // Handle three dots button press
            //       print("Three dots button pressed for item: ${item.name}");
            //       showModalBottomSheet(
            //         context: context,
            //         shape: const RoundedRectangleBorder(
            //           borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(16.0),
            //             topRight: Radius.circular(16.0),
            //           ),
            //         ),
            //         builder: (BuildContext context) {
            //           return isTrashed
            //               ? BottomModalOptions(item, isTrashed: isTrashed, colorScheme: colorScheme,)
            //               : BottomModalOptions(item,
            //                   onStarred: onStarred,
            //                   renameFolder: renameFolder,
            //                   deleteItem: deleteItem,
            //                   isTrashed: isTrashed,
            //                   parentFolderId: parentFolderId,
            //                   pasteFileOrFolder: pasteFileOrFolder,
            //                   colorScheme: colorScheme,
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

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
