// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
//
// class PdfViewerPage extends StatefulWidget {
//   final String filePath;
//
//   final String fileName;
//
//   const PdfViewerPage({Key? key, required this.filePath, required this.fileName}) : super(key: key);
//
//   @override
//   _PdfViewerPageState createState() => _PdfViewerPageState();
// }
//
// class _PdfViewerPageState extends State<PdfViewerPage> {
//   String? localFilePath;
//   bool isLoading = true;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _preparePdf(widget.filePath);
//   }
//
//   Future<void> _preparePdf(String url) async {
//     try {
//       // Get temporary directory
//       final tempDir = await getTemporaryDirectory();
//       final filePath = '${tempDir.path}/temp.pdf';
//
//       // Download the file
//       final dio = Dio();
//       await dio.download(url, filePath);
//
//       // Set the local file path
//       setState(() {
//         localFilePath = filePath;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error downloading PDF: $e");
//       setState(() {
//         isLoading = false; // Stop loader on error
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to load PDF: $e")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.fileName)),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : localFilePath != null
//           ? PDFView(
//         filePath: localFilePath!,
//         enableSwipe: true,
//         swipeHorizontal: false,
//         autoSpacing: false,
//         pageFling: false,
//       )
//           : const Center(child: Text("Failed to load PDF")),
//     );
//   }
// }








// IOS LOOK AND FEEL CODE:

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For ColorScheme & other references
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' as Foundation;

class PdfViewerPage extends StatefulWidget {
  final String filePath;

  final String fileName;

  const PdfViewerPage({Key? key, required this.filePath, required this.fileName}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? localFilePath;
  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    if (widget.filePath.contains('http') || widget.filePath.contains('https')) {
      _preparePdfFromUrl(widget.filePath);
    } else {
      // Handle local mobile file path
      setState(() {
        localFilePath = widget.filePath;
        isLoading = false;
      });
    }
  }

  Future<void> _preparePdfFromUrl(String url) async {
    try {
      // Get temporary directory for the web case
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/temp.pdf';

      // Download the file
      final dio = Dio();
      await dio.download(url, filePath);

      // Set the local file path
      setState(() {
        localFilePath = filePath;
        isLoading = false;
      });
    } catch (e) {
      print("Error downloading PDF: $e");
      setState(() {
        isLoading = false;
      });
      // Use Cupertino-style alert
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Error"),
          content: Text("Failed to load PDF: $e"),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.fileName),
      ),
      child: SafeArea(
        child: isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : localFilePath != null
            ? PDFView(
          filePath: localFilePath!,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          pageFling: false,
        )
            : const Center(child: Text("Failed to load PDF")),
      ),
    );
  }
}
