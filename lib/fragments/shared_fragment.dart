import 'package:flutter/material.dart';
import '../data/create_fileStructure.dart';
import '../data/file_class.dart';
import '../data/file_data.dart';
import '../widgets/floating_action_button_widget.dart';
import 'package:flutter/cupertino.dart';

class SharedFragment extends StatefulWidget {
  // final bool isGridView;
  final ColorScheme colorScheme;

  const SharedFragment({
    // required this.isGridView,
    required this.colorScheme,
    super.key,
  });

  @override
  State<SharedFragment> createState() => _SharedFragmentState();
}

class _SharedFragmentState extends State<SharedFragment> {
  late bool isGridView = false;
  // If you maintain a list of files elsewhere, ensure it is defined accordingly.
  // For demonstration, we assume 'allItems' is maintained somewhere in your app.
  // (If needed, you can declare a local list here.)
  // final List<FileItemNew> allItems = [];

  void _onFilesAdded(List<FileItemNew> newFiles) {
    setState(() {
      // Add new files to your existing items (adjust this as needed for your app)
      // allItems.addAll(newFiles);
    });
  }

  
  void _toggleViewMode() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // If you want a title for each tab's top bar:
        leading: CupertinoButton(
          child: Icon(CupertinoIcons.refresh),
          onPressed: (){},
        ),
        middle: Text(
          // ['Home', 'Shared', 'Starred'][index],
          "Shared",
          style: TextStyle(
            color: widget.colorScheme.primary,
          ),
        ),
        trailing: CupertinoButton(
          onPressed: _toggleViewMode,
          padding: EdgeInsets.zero,
          child: Icon(
            isGridView
                ? CupertinoIcons.list_bullet
                : CupertinoIcons.square_grid_2x2,
            color: widget.colorScheme.primary,
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Main content in the center
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/share.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'You don\'t have any Shared Files',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
            // Floating action button positioned at the bottom-right.
            Positioned(
              bottom: 20,
              right: 20,
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
}



// class SharedFragment extends StatefulWidget{
//   final bool isGridView;
//   final ColorScheme colorScheme;
//   const SharedFragment({required this.isGridView, required this.colorScheme, super.key});
//
//   @override
//   State<SharedFragment> createState() {
//     // TODO: implement createState
//     return _SharedFragmentState();
//   }
// }
//
// class _SharedFragmentState extends State<SharedFragment>{
//
//   void _onFilesAdded(List<FileItemNew> newFiles) {
//     setState(() {
//       // items.addAll(newFiles);
//       allItems.addAll(newFiles);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       floatingActionButton: FloatingActionButtonWidget(onFilesAdded: _onFilesAdded, isFolderUpload: false, folderName: "", colorScheme: widget.colorScheme,),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/share.png',
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 5),
//                   // Header
//                   const Text(
//                     'You don\'t have any Shared Files',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }