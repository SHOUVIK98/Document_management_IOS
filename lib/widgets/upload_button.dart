// import 'package:flutter/material.dart';
//
// class UploadButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final IconData icon;
//   final String label;
//
//   const UploadButton({
//     Key? key,
//     required this.onTap,
//     required this.icon,
//     required this.label,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final isLightTheme = Theme.of(context).brightness == Brightness.light;
//
//     return Column(
//       children: [
//         InkWell(
//           onTap: onTap,
//           child: Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.grey[200],
//             ),
//             child: Icon(icon, color: Colors.black),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(fontSize: 12, color: isLightTheme ? Colors.black : Colors.white),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final bool? isDarkMode;

  const UploadButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label, 
    this.isDarkMode,
    
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          onPressed: onTap,
          padding: EdgeInsets.zero, // Removes default padding
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.systemGrey5, // Matches iOS style
            ),
            child: Icon(icon, color: CupertinoColors.black),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: (isDarkMode ?? false) ? CupertinoColors.white : CupertinoColors.black,
            decoration: TextDecoration.none, // Fixes yellow underline
            decorationColor: Colors.transparent,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
