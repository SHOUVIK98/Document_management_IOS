import 'package:document_management_main/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For ColorScheme, etc.
import 'data/create_fileStructure.dart';
import 'fragments/home_fragment.dart';
import 'fragments/shared_fragment.dart';
import 'fragments/starred_fragment.dart';
import 'utils/file_data_service_util.dart';

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

  /// The same search logic used previously.
  List<FileItemNew> _searchAllItems(String query, List<FileItemNew> items) {
    final results = <FileItemNew>[];
    for (var item in items) {
      // If the item's name contains the query (case-insensitive), add it to results.
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        results.add(item);
      }
      // If this item has children, search them too.
      if (item.children != null && item.children!.isNotEmpty) {
        results.addAll(_searchAllItems(query, item.children!));
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    // You can style the tab bar with iOS-like colors,
    // including your widget.colorScheme if you wish:
    final Brightness brightness =
        widget.isDarkMode ? Brightness.dark : Brightness.light;
    List<FileItemNew> _searchResults = [];

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
            // isGridView: isGridView,
          ),
          SharedFragment(
            // isGridView: isGridView,
            colorScheme: widget.colorScheme,
          ),
          StarredFragment(
            colorScheme: widget.colorScheme,
            // isGridView: isGridView,
          ),
        ];

        return CupertinoPageScaffold(
          // navigationBar: CupertinoNavigationBar(
          //   // If you want a title for each tab's top bar:
          //   leading: CupertinoButton(
          //     child: Icon(CupertinoIcons.refresh),
          //     onPressed: (){},
          //   ),
          //   middle: Text(
          //     ['Home', 'Shared', 'Starred'][index],
          //     style: TextStyle(
          //       color: widget.colorScheme.primary,
          //     ),
          //   ),
          //   trailing: CupertinoButton(
          //     onPressed: _toggleViewMode,
          //     padding: EdgeInsets.zero,
          //     child: Icon(
          //       isGridView
          //           ? CupertinoIcons.list_bullet
          //           : CupertinoIcons.square_grid_2x2,
          //       color: widget.colorScheme.primary,
          //     ),
          //   ),
          // ),
          child: SafeArea(
            child: Column(
              children: [
                // The toggle button row
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // CupertinoButton(
                    //   onPressed: _toggleViewMode,
                    //   padding: EdgeInsets.zero,
                    //   child: Icon(
                    //     isGridView
                    //         ? CupertinoIcons.list_bullet
                    //         : CupertinoIcons.square_grid_2x2,
                    //     color: widget.colorScheme.primary,
                    //   ),
                    // ),
                    // const SizedBox(width: 16),
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
