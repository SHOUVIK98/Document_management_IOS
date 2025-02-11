// import 'package:flutter/material.dart';
// import 'fragments/home_fragment.dart';
// import 'fragments/shared_fragment.dart';
// import 'fragments/starred_fragment.dart';

// class BottomNavigation extends StatefulWidget {
//   final ColorScheme colorScheme;
//   final bool isDarkMode;
//   final ThemeMode themeMode;
//   final void Function(bool isDark) updateTheme;
//   final void Function(ColorScheme newScheme) updateColorScheme;
//   const BottomNavigation(
//       {super.key,
//       required this.isDarkMode,
//       required this.themeMode,
//       required this.updateTheme,
//       required this.updateColorScheme,
//       required this.colorScheme});

//   @override
//   State<BottomNavigation> createState() {
//     // TODO: implement createState
//     return _BottomNavigationState();
//   }
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   int currentPageIndex = 0;
//   bool isGridView = false;

//   void _toggleViewMode() {
//     setState(() {
//       isGridView = !isGridView;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     final ThemeData theme = Theme.of(context);
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         indicatorColor: widget.colorScheme.secondary,
//         selectedIndex: currentPageIndex,
//         destinations: const <Widget>[
//           NavigationDestination(
//             selectedIcon: Icon(Icons.home),
//             icon: Icon(Icons.home_outlined),
//             label: "Home",
//           ),
//           NavigationDestination(
//               icon: Icon(Icons.people_alt_outlined),
//               selectedIcon: Icon(Icons.people),
//               label: "Shared"),
//           NavigationDestination(
//               icon: Icon(Icons.star_border_outlined),
//               selectedIcon: Icon(Icons.star),
//               label: "Starred")
//         ],
//       ),
//       body: Column(
//         children: [
//           // Toggle button
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               // const Padding(padding: EdgeInsets.only(left: 340.0)),
//               IconButton(
//                 icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
//                 onPressed: _toggleViewMode,
//               ),
//               const SizedBox(width: 28.0),
//             ],
//           ),
//           // Content
//           Expanded(
//             child: <Widget>[
//               HomeFragment(
//                 colorScheme: widget.colorScheme,
//                 themeMode: widget.themeMode,
//                 // isDarkMode: widget.isDarkMode,
//                 updateTheme: widget.updateTheme,
//                 updateColorScheme: widget.updateColorScheme,
//                 isGridView: isGridView,
//               ),
//               SharedFragment(
//                 isGridView: isGridView,
//                 colorScheme: widget.colorScheme,
//               ),
//               StarredFragment(
//                 colorScheme: widget.colorScheme,
//                 isGridView: isGridView,
//               ),
//             ][currentPageIndex],
//           ),
//         ],
//       ),
//     );
//   }
// }









//IOS LOOK AND FEEL CODE
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For ColorScheme, etc.
import 'fragments/home_fragment.dart';
import 'fragments/shared_fragment.dart';
import 'fragments/starred_fragment.dart';

class BottomNavigation extends StatefulWidget {
  final ColorScheme colorScheme;
  final bool isDarkMode;
  final ThemeMode themeMode;
  final void Function(bool isDark) updateTheme;
  final void Function(ColorScheme newScheme) updateColorScheme;

  const BottomNavigation({
    super.key,
    required this.isDarkMode,
    required this.themeMode,
    required this.updateTheme,
    required this.updateColorScheme,
    required this.colorScheme,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;
  bool isGridView = false;

  void _toggleViewMode() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    // You can style the tab bar with iOS-like colors,
    // including your widget.colorScheme if you wish:
    final Brightness brightness =
        widget.isDarkMode ? Brightness.dark : Brightness.light;

    return CupertinoTabScaffold(
      // CupertinoTabBar is the iOS-style bottom navigation.
      tabBar: CupertinoTabBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },

//
        activeColor: widget.colorScheme.primary, // or any accent color
        inactiveColor: widget.colorScheme.onSurface.withOpacity(0.6),
        backgroundColor: widget.colorScheme.background,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2),
            label: "Shared",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.star),
            label: "Starred",
          ),
        ],
      ),

      // This is how we build each “tab page.” iOS typically gives each tab its
      // own navigation stack, but here we’ll just display whichever fragment
      // is selected, along with a top Row for the “Grid/List” toggle.
      tabBuilder: (BuildContext context, int index) {
        final pages = <Widget>[
          HomeFragment(
            colorScheme: widget.colorScheme,
            themeMode: widget.themeMode,
            updateTheme: widget.updateTheme,
            updateColorScheme: widget.updateColorScheme,
            isGridView: isGridView,
          ),
          SharedFragment(
            isGridView: isGridView,
            colorScheme: widget.colorScheme,
          ),
          StarredFragment(
            colorScheme: widget.colorScheme,
            isGridView: isGridView,
          ),
        ];

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            // If you want a title for each tab's top bar:
            middle: Text(
              ['Home', 'Shared', 'Starred'][index],
              style: TextStyle(
                color: widget.colorScheme.primary,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // The toggle button row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      onPressed: _toggleViewMode,
                      padding: EdgeInsets.zero,
                      child: Icon(
                        isGridView
                            ? CupertinoIcons.list_bullet
                            : CupertinoIcons.square_grid_2x2,
                        color: widget.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
                // Expanded content for the current tab
                Expanded(
                  child: pages[index],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
