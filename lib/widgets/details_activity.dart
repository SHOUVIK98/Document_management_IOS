import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data/create_fileStructure.dart';

class DetailsActivity extends StatelessWidget {
  final FileItemNew item;
  const DetailsActivity({super.key, required this.item});

  Future<int> _getFileSize(String url) async {
    final response = await http.head(Uri.parse(url));
    if (response.headers.containsKey('content-length')) {
      return int.parse(response.headers['content-length']!);
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Info"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            "Done",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File Preview
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: CupertinoColors.systemGrey5,
                    ),
                    child: Icon(
                      item.isFolder
                          ? CupertinoIcons.folder_fill
                          : CupertinoIcons.doc_text_fill,
                      size: 60,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // File Name & Type
                Center(
                  child: Column(
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.black,
                          decoration:
                              TextDecoration.none, // Fixes yellow underline
                          decorationColor: Colors.transparent,
                          fontFamily: '.SF UI Text',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.isFolder ? "Folder" : "File",
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemGrey,
                          decoration:
                              TextDecoration.none, // Fixes yellow underline
                          decorationColor: Colors.transparent,
                          fontFamily: '.SF UI Text',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Open Button
                // Center(
                //   child: CupertinoButton.filled(
                //     child: const Text("Open"),
                //     onPressed: () {
                //       // Implement open file logic
                //     },
                //   ),
                // ),
                const SizedBox(height: 20),

                // File Details
                _buildDetailSection("Information", [
                  _buildDetailRow("Kind", item.isFolder ? "Folder" : "File"),
                  item.isFolder
                      ? _buildDetailRow("Size", "n/a")
                      : FutureBuilder<int>(
                          future: _getFileSize(item.filePath!),
                          builder: (context, snapshot) {
                            String fileSizeText = "Calculating...";
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              final sizeInBytes = snapshot.data!;
                              final sizeInKB = sizeInBytes / 1024;
                              final sizeInMB = sizeInKB / 1024;
                              fileSizeText = sizeInMB >= 1
                                  ? "${sizeInMB.toStringAsFixed(2)} MB"
                                  : "${sizeInKB.toStringAsFixed(2)} KB";
                            }
                            return _buildDetailRow("Size", fileSizeText);
                          },
                        ),
                  _buildDetailRow(
                    "Created",
                    DateFormat("dd MMM yyyy hh:mm a").format(
                      DateTime.parse(item.otherDetails['createdOn']),
                    ),
                  ),
                  _buildDetailRow(
                    "Modified",
                    DateFormat("dd MMM yyyy hh:mm a").format(
                      DateTime.parse(item.otherDetails['updatedOn']),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.activeBlue,
            decoration: TextDecoration.none, // Fixes yellow underline
            decorationColor: Colors.transparent,
            fontFamily: '.SF UI Text',
          ),
        ),
        ...children,
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.systemGrey,
              decoration: TextDecoration.none, // Fixes yellow underline
              decorationColor: Colors.transparent,
              fontFamily: '.SF UI Text',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.black,
              decoration: TextDecoration.none, // Fixes yellow underline
              decorationColor: Colors.transparent,
              fontFamily: '.SF UI Text',
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// import '../data/create_fileStructure.dart';

// class DetailsActivity extends StatelessWidget {
//   final FileItemNew item;
//   const DetailsActivity({super.key, required this.item});

//   Future<int> _getFileSize(String url) async {
//     final response = await http.head(Uri.parse(url));
//     if (response.headers.containsKey('content-length')) {
//       return int.parse(response.headers['content-length']!);
//     }
//     return 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPopupSurface(
//       isSurfacePainted: true,
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         height: MediaQuery.of(context).size.height * 0.5, // Adjustable height
//         child: CupertinoScrollbar(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "File Details",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 CupertinoListTile(
//                   leading: const Icon(CupertinoIcons.doc),
//                   title: Text(item.name),
//                   subtitle: item.isFolder
//                       ? const Text("")
//                       : FutureBuilder<int>(
//                           future: _getFileSize(item.filePath!),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return const Text("Calculating size...");
//                             } else if (snapshot.hasError) {
//                               return const Text("Error calculating size");
//                             } else {
//                               final sizeInBytes = snapshot.data!;
//                               final sizeInKB = sizeInBytes / 1024;
//                               final sizeInMB = sizeInKB / 1024;
//                               return Text(
//                                 sizeInMB >= 1
//                                     ? "${sizeInMB.toStringAsFixed(2)} MB"
//                                     : "${sizeInKB.toStringAsFixed(2)} KB",
//                               );
//                             }
//                           },
//                         ),
//                 ),
//                 CupertinoListTile(
//                   leading: const Icon(CupertinoIcons.calendar),
//                   title: const Text("Modified"),
//                   subtitle: Text(
//                     DateFormat("dd/MM/yy hh:mm").format(
//                       DateTime.parse(item.otherDetails['updatedOn']),
//                     ),
//                   ),
//                 ),
//                 const Divider(),
//                 const Text(
//                   "Activity",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 CupertinoListTile(
//                   leading: const Icon(CupertinoIcons.pencil),
//                   title: Text("Edited by ${userIdUserDetailsMap[item.otherDetails['updatedBy']]["USER_NAME"]}"),
//                   subtitle: Text(
//                     DateFormat("dd/MM/yy hh:mm").format(
//                       DateTime.parse(item.otherDetails['updatedOn']),
//                     ),
//                   ),
//                 ),
//                 CupertinoListTile(
//                   leading: const Icon(CupertinoIcons.share),
//                   title: Text("Created by ${userIdUserDetailsMap[item.otherDetails['createdBy']]["USER_NAME"]}"),
//                   subtitle: Text(
//                     DateFormat("dd/MM/yy hh:mm").format(
//                       DateTime.parse(item.otherDetails['createdOn']),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Center(
//                   child: CupertinoButton.filled(
//                     child: const Text("Close"),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:io';

// import 'package:document_management_main/data/create_fileStructure.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class DetailsActivity extends StatelessWidget {
//   final FileItemNew item;
//   const DetailsActivity({super.key, required this.item});

//   // final fileSize = File(item.filePath!).lengthSync();
//     Future<int> _getFileSize(String url) async {
//     final response = await http.head(Uri.parse(url));
//     if (response.headers.containsKey('content-length')) {
//       return int.parse(response.headers['content-length']!);
//     }
//     return 0;
//   }

//   @override
//   Widget build(BuildContext context) {

//     void calculateFolderSize(){

//     }
    
//     return DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.5, // 40% of screen height
//       minChildSize: 0.2, // Minimum size
//       maxChildSize: 0.8, // Maximum size
//       builder: (context, scrollController) {
//         return SingleChildScrollView(
//           controller: scrollController,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text("File Details",
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 ListTile(
//                   leading: const Icon(Icons.insert_drive_file),
//                   title: Text(item.name),
//                   subtitle:  item.isFolder
//                       ? const Text("")
//                       : FutureBuilder<int>(
//                           future: _getFileSize(item.filePath!),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return const Text("Calculating size...");
//                             } else if (snapshot.hasError) {
//                               return const Text("Error calculating size");
//                             } else {
//                               final sizeInBytes = snapshot.data!;
//                               final sizeInKB = sizeInBytes / 1024;
//                               final sizeInMB = sizeInKB / 1024;
//                               return Text(
//                                 sizeInMB >= 1
//                                     ? "${sizeInMB.toStringAsFixed(2)} MB"
//                                     : "${sizeInKB.toStringAsFixed(2)} KB",
//                               );
//                             }
//                           },
//                         ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.date_range),
//                   title: const Text("Modified"),
//                   subtitle: Text(DateFormat("dd/MM/yy hh:mm").format(
//                       DateTime.parse(item.otherDetails['updatedOn']),
//                     ),),
//                 ),
//                 const Divider(),
//                 const Text("Activity",
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 ListTile(
//                   leading: const Icon(Icons.edit),
//                   title: Text("Edited by ${userIdUserDetailsMap[item.otherDetails['updatedBy']]["USER_NAME"]}"),
//                   subtitle: Text(DateFormat("dd/MM/yy hh:mm").format(
//                       DateTime.parse(item.otherDetails['updatedOn']),
//                     )),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.share),
//                   title: Text("Created by ${userIdUserDetailsMap[item.otherDetails['createdBy']]["USER_NAME"]}"),
//                   subtitle: Text(DateFormat("dd/MM/yy hh:mm").format(
//                       DateTime.parse(item.otherDetails['createdOn']),
//                     ),),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
