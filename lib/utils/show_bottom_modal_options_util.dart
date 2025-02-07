import 'package:flutter/cupertino.dart';

import '../data/create_fileStructure.dart';
import '../widgets/bottom_modal_options.dart';

void showOptions(
    BuildContext context,
    FileItemNew item,
    final Function(FileItemNew)? onStarred,
    final Function(String, FileItemNew item)? renameFolder,
    final Function(FileItemNew item, dynamic parentFolderId)? deleteItem,
    final bool isTrashed,
    final dynamic parentFolderId) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext ctx) {
      // If you want to keep your existing Material bottom sheet design,
      // you can wrap it in a CupertinoPopupSurface or use a CupertinoActionSheet.
      // For simplicity, let's just embed your existing bottom sheet widget:
      return BottomModalOptions(
        item,
        onStarred: onStarred,
        renameFolder: renameFolder,
        deleteItem: deleteItem,
        isTrashed: isTrashed,
        parentFolderId: parentFolderId,
      );
    },
  );
}
