// import 'package:document_management_main/widgets/search_bar_widget.dart';
// import 'package:flutter/material.dart';
// import 'bottom_navigation.dart';
// import 'data/profile_page_menu_data.dart';
// import 'dart:io';
// import 'package:menu_submenu_sidebar_dropdown_accordian_package/menu_submenu_sidebar_dropdown_accordian_package.dart';

// class DocumentManagementEntryPoint extends StatefulWidget {
//   const DocumentManagementEntryPoint({super.key});

//   @override
//   State<DocumentManagementEntryPoint> createState() =>
//       _DocumentManagementEntryPointState();
// }

// class _DocumentManagementEntryPointState
//     extends State<DocumentManagementEntryPoint> {
//   bool _isDarkMode = false;
//   late ColorScheme _colorScheme;
//   late ThemeMode themeMode;

//   @override
//   void initState() {
//     super.initState();
//     themeMode = ThemeMode.system;
//     _colorScheme = ColorScheme.fromSwatch(
//       brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//     );
//   }

//   void toggleTheme() {
//     setState(() {
//       _isDarkMode = themeMode == ThemeMode.light ? true : false;
//       themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
//       _colorScheme = ColorScheme.fromSwatch(
//         brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//       );
//     });
//   }

//   void _updateTheme(bool isDark) {
//     setState(() {
//       _isDarkMode = isDark;
//       themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
//       _colorScheme = ColorScheme.fromSwatch(
//         brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//       );
//     });
//   }

//   void _updateColorScheme(ColorScheme newScheme) {
//     setState(() {
//       _colorScheme = newScheme;
//     });
//   }

//   void _onMenuItemSelected(Widget widget) {
//     setState(() {
//       // Handle navigation or widget replacement based on selection
//       // For example, navigate to a new page
// // Reset or set based on selection
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Document Management',
//       theme: ThemeData.from(
//         colorScheme: _colorScheme,
//         useMaterial3: true,
//       ),
//       darkTheme: ThemeData.from(
//         colorScheme: _colorScheme.copyWith(brightness: Brightness.dark),
//         useMaterial3: true,
//       ),
//       themeMode: themeMode,
//       home: Scaffold(
//         drawer: Drawer( 
//           child: MenuWithSubMenu(
//             menuItems: menuItems,
//             themeMode: themeMode,
//             colorScheme: _colorScheme,
//             updateTheme: _updateTheme,
//             updateColorScheme: _updateColorScheme,
//             // onMenuItemSelected: _onMenuItemSelected,
//           ),
//         ),
//         appBar: AppBar(
//           title: Text(
//             "Document Management",
//             style: TextStyle(color: _colorScheme.primary),
//           ),
//           actions:const [
//              Padding(
//               padding:  EdgeInsets.fromLTRB(0.0, 0.0, 22.0, 0.0),
//               child:  SearchBarWidget(),
//             ),
//           ],
//         ),
//         body: BottomNavigation(
//           colorScheme: _colorScheme,
//           themeMode: themeMode,
//           isDarkMode: _isDarkMode,
//           updateTheme: _updateTheme,
//           updateColorScheme: _updateColorScheme,
//         ),
//       ),
//     );
//   }
// }







// IOS LOOK AND FEEL CODE

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // May still need for ColorScheme & other references
import 'package:document_management_main/widgets/search_bar_widget.dart';
import 'bottom_navigation.dart';
import 'data/profile_page_menu_data.dart';
import 'dart:io';
import 'package:menu_submenu_sidebar_dropdown_accordian_package/menu_submenu_sidebar_dropdown_accordian_package.dart';

class DocumentManagementEntryPoint extends StatefulWidget {
  const DocumentManagementEntryPoint({super.key});

  @override
  State<DocumentManagementEntryPoint> createState() =>
      _DocumentManagementEntryPointState();
}

class _DocumentManagementEntryPointState
    extends State<DocumentManagementEntryPoint> {
  bool _isDarkMode = false;
  late ColorScheme _colorScheme;
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = ThemeMode.system;
    _colorScheme = ColorScheme.fromSwatch(
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
    );
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = themeMode == ThemeMode.light;
      themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _colorScheme = ColorScheme.fromSwatch(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      );
    });
  }

  void _updateTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
      themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _colorScheme = ColorScheme.fromSwatch(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      );
    });
  }

  void _updateColorScheme(ColorScheme newScheme) {
    setState(() {
      _colorScheme = newScheme;
    });
  }

  void _onMenuItemSelected(Widget widget) {
    // Handle navigation or widget replacement based on selection
    // e.g., setState(() { /* navigate to or show new widget */ });
  }

  @override
  Widget build(BuildContext context) {
    // Because CupertinoApp doesn’t have a direct darkTheme property,
    // you will handle the brightness explicitly:
    final brightness =
        _isDarkMode ? Brightness.dark : Brightness.light;

    return CupertinoApp(
        debugShowCheckedModeBanner: false,
          title: 'Document Management',
          // Apply some Cupertino theming based on our colorScheme:
          theme: CupertinoThemeData(
            brightness: brightness,
            primaryColor: _colorScheme.primary,
            // You can also adjust text styles, etc.
          ),
          home: CupertinoPageScaffold(
            // iOS typically doesn’t have a “Drawer,” so consider a custom side menu
            // or a modal sheet. For demonstration, we show a button in the nav bar
            // that triggers a Cupertino-style modal to replicate the “drawer” content.
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                "Document Management",
                style: TextStyle(
                  color: _colorScheme.primary,
                ),
              ),
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Example: an icon to open a 'drawer-like' modal
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _showDrawerModal, // see method below
                    child: Icon(
                      CupertinoIcons.square_list,
                      color: _colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // The trailing SearchBarWidget (assuming it’s already Cupertino-compatible):
                  // const Padding(
                  //   padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                  //   child: SearchBarWidget(),
                  // ),
                ],
              ),
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children : [
                    Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                    child: SearchBarWidget(),
                  ),
                ]
              )
            ),
            child: SafeArea(
              child: BottomNavigation(
                colorScheme: _colorScheme,
                themeMode: themeMode,
                isDarkMode: _isDarkMode,
                updateTheme: _updateTheme,
                updateColorScheme: _updateColorScheme,
              ),
            ),
          ),
        );
  }

  // Example method to show a Cupertino-style “drawer”
  // (actually a modal popup) with your menu items:
  void _showDrawerModal() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text("Menu"),
          message: SizedBox(
            height: 400,
            child: MenuWithSubMenu(
              menuItems: menuItems,
              themeMode: themeMode,
              colorScheme: _colorScheme,
              updateTheme: _updateTheme,
              updateColorScheme: _updateColorScheme,
              // onMenuItemSelected: _onMenuItemSelected,
            ),
          ),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        );
      },
    );
  }
}









// IOS CODE LOOK AND FEEL PART 2

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart'; // For ColorScheme & other references
// import 'package:document_management_main/widgets/search_bar_widget.dart';
// import 'bottom_navigation.dart';
// import 'data/profile_page_menu_data.dart';
// import 'dart:io';
// import 'package:menu_submenu_sidebar_dropdown_accordian_package/menu_submenu_sidebar_dropdown_accordian_package.dart';

// class DocumentManagementEntryPoint extends StatefulWidget {
//   const DocumentManagementEntryPoint({super.key});

//   @override
//   State<DocumentManagementEntryPoint> createState() =>
//       _DocumentManagementEntryPointState();
// }

// class _DocumentManagementEntryPointState
//     extends State<DocumentManagementEntryPoint> {
//   bool _isDarkMode = false;
//   late ColorScheme _colorScheme;
//   late ThemeMode themeMode;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     themeMode = ThemeMode.system;
//     _colorScheme = ColorScheme.fromSwatch(
//       brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//     );
//   }

//   void toggleTheme() {
//     setState(() {
//       _isDarkMode = themeMode == ThemeMode.light;
//       themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
//       _colorScheme = ColorScheme.fromSwatch(
//         brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//       );
//     });
//   }

//   void _updateTheme(bool isDark) {
//     setState(() {
//       _isDarkMode = isDark;
//       themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
//       _colorScheme = ColorScheme.fromSwatch(
//         brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//       );
//     });
//   }

//   void _updateColorScheme(ColorScheme newScheme) {
//     setState(() {
//       _colorScheme = newScheme;
//     });
//   }

//   void _onMenuItemSelected(Widget widget) {
//     // Handle navigation or widget replacement based on selection
//     // e.g., setState(() { /* navigate to or show new widget */ });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Because CupertinoApp doesn’t have a direct darkTheme property,
//     // you will handle the brightness explicitly:
//     final brightness =
//         _isDarkMode ? Brightness.dark : Brightness.light;

//     return CupertinoApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Document Management',
//       theme: CupertinoThemeData(
//         brightness: brightness,
//         primaryColor: _colorScheme.primary,
//         // You can also adjust text styles, etc.
//       ),
//       home: CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           middle: Text(
//             "Document Management",
//             style: TextStyle(
//               color: _colorScheme.primary,
//             ),
//           ),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Example: an icon to open the "sidebar" menu
//               CupertinoButton(
//                 padding: EdgeInsets.zero,
//                 onPressed: _openSidebarMenu,
//                 child: Icon(
//                   CupertinoIcons.square_list,
//                   color: _colorScheme.primary,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               // The trailing SearchBarWidget (assuming it’s already Cupertino-compatible):
//               const Padding(
//                 padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
//                 child: SearchBarWidget(),
//               ),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: BottomNavigation(
//             colorScheme: _colorScheme,
//             themeMode: themeMode,
//             isDarkMode: _isDarkMode,
//             updateTheme: _updateTheme,
//             updateColorScheme: _updateColorScheme,
//           ),
//         ),
//       ),
//     );
//   }

//   // Method to open the sidebar with the MenuWithSubMenu widget
//   void _openSidebarMenu() {
//     _scaffoldKey.currentState?.openDrawer();
//   }

//   @override
//   Widget buildSidebarMenu() {
//     return Drawer(
//       key: _scaffoldKey,
//       child: MenuWithSubMenu(
//         menuItems: menuItems,
//         themeMode: themeMode,
//         colorScheme: _colorScheme,
//         updateTheme: _updateTheme,
//         updateColorScheme: _updateColorScheme,
//         // onMenuItemSelected: _onMenuItemSelected,
//       ),
//     );
//   }
// }
