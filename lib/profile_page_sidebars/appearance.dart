// import 'package:flutter/material.dart';
// import '../theme/color_picker_selection.dart';
// import '../theme/theme_selector.dart';
//
// class Appearance extends StatefulWidget {
//   final ColorScheme colorScheme;
//   final ThemeMode themeMode;
//   final Function(bool isDarkMode) onThemeChanged;
//   final Function(ColorScheme colorScheme) onColorSchemeChanged;
//
//   const Appearance({
//     Key? key,
//     required this.onThemeChanged,
//     required this.onColorSchemeChanged,
//     required this.colorScheme,
//     required this.themeMode,
//   }) : super(key: key);
//
//   @override
//   _AppearanceState createState() => _AppearanceState();
// }
//
// class _AppearanceState extends State<Appearance> {
//   bool _isDarkMode = false;
//   late ColorScheme _colorScheme;
//
//   @override
//   void initState() {
//     super.initState();
//     _isDarkMode = widget.themeMode == ThemeMode.dark;
//     _colorScheme = widget.colorScheme;
//   }
//
//   void _toggleTheme(bool isDark) {
//     setState(() {
//       _isDarkMode = isDark;
//       _colorScheme = _isDarkMode
//           ? ColorScheme.fromSwatch(brightness: Brightness.dark)
//           : ColorScheme.fromSwatch(brightness: Brightness.light);
//     });
//     widget.onThemeChanged(_isDarkMode);
//     widget.onColorSchemeChanged(_colorScheme);
//   }
//
//   void _updateColorScheme(ColorScheme newScheme) {
//     setState(() {
//       _colorScheme = newScheme;
//     });
//     widget.onColorSchemeChanged(_colorScheme);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.from(
//         colorScheme: _colorScheme,
//         useMaterial3: true,
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Appearance Settings',
//             style: TextStyle(
//                 color: widget.colorScheme.primary
//             ),
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ThemeSelector(
//                 isDarkMode: _isDarkMode,
//                 onThemeSelected: _toggleTheme,
//                 colorScheme: widget.colorScheme,
//               ),
//               const SizedBox(height: 20),
//               // ColorPickerSection(
//               //   colorScheme: _colorScheme,
//               //   onColorSchemeChanged: _updateColorScheme,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../theme/color_picker_selection.dart';
// import '../theme/theme_selector.dart';
//
// class Appearance extends StatefulWidget {
//   final ColorScheme colorScheme;
//   final ThemeMode themeMode;
//   final Function(bool isDarkMode) onThemeChanged;
//   final Function(ColorScheme colorScheme) onColorSchemeChanged;
//
//   const Appearance({
//     Key? key,
//     required this.onThemeChanged,
//     required this.onColorSchemeChanged,
//     required this.colorScheme,
//     required this.themeMode,
//   }) : super(key: key);
//
//   @override
//   _AppearanceState createState() => _AppearanceState();
// }
//
// class _AppearanceState extends State<Appearance> {
//   bool _isDarkMode = false;
//   late ColorScheme _colorScheme;
//
//   @override
//   void initState() {
//     super.initState();
//     _isDarkMode = widget.themeMode == ThemeMode.dark;
//     _colorScheme = widget.colorScheme;
//   }
//
//   void _toggleTheme(bool isDark) {
//     setState(() {
//       _isDarkMode = isDark;
//       _colorScheme = _isDarkMode
//           ? ColorScheme.fromSwatch(brightness: Brightness.dark)
//           : ColorScheme.fromSwatch(brightness: Brightness.light);
//     });
//     widget.onThemeChanged(_isDarkMode);
//     widget.onColorSchemeChanged(_colorScheme);
//   }
//
//   void _updateColorScheme(ColorScheme newScheme) {
//     setState(() {
//       _colorScheme = newScheme;
//     });
//     widget.onColorSchemeChanged(_colorScheme);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       theme: CupertinoThemeData(
//         primaryColor: _colorScheme.primary,
//         brightness: _isDarkMode ? Brightness.dark : Brightness.light,
//       ),
//       home: CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           middle: Text(
//             'Appearance Settings',
//               style: TextStyle(color: widget.colorScheme.primary,fontSize: 22),
//           ),
//           leading: CupertinoButton(
//             padding: EdgeInsets.zero,
//             child:  Icon(
//               CupertinoIcons.back,
//               color: _isDarkMode ? CupertinoColors.white : CupertinoColors.black, // Dark mode icon color
//               size: 32, // Set the size to make it larger
//             ),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ThemeSelector(
//                   isDarkMode: _isDarkMode,
//                   onThemeSelected: _toggleTheme,
//                   colorScheme: widget.colorScheme,
//                 ),
//                 const SizedBox(height: 20),
//                 // ColorPickerSection(
//                 //   colorScheme: _colorScheme,
//                 //   onColorSchemeChanged: _updateColorScheme,
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

////////////// ui change new ///////////////////////
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/color_picker_selection.dart';
import '../theme/theme_selector.dart';

class Appearance extends StatefulWidget {
  final ColorScheme colorScheme;
  final ThemeMode themeMode;
  final Function(bool isDarkMode) onThemeChanged;
  final Function(ColorScheme colorScheme) onColorSchemeChanged;

  const Appearance({
    Key? key,
    required this.onThemeChanged,
    required this.onColorSchemeChanged,
    required this.colorScheme,
    required this.themeMode,
  }) : super(key: key);

  @override
  _AppearanceState createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  bool _isDarkMode = false;
  late ColorScheme _colorScheme;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.themeMode == ThemeMode.dark;
    _colorScheme = widget.colorScheme;
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
      _colorScheme = _isDarkMode
          ? ColorScheme.fromSwatch(brightness: Brightness.dark)
          : ColorScheme.fromSwatch(brightness: Brightness.light);
    });
    widget.onThemeChanged(_isDarkMode);
    widget.onColorSchemeChanged(_colorScheme);
  }

  void _updateColorScheme(ColorScheme newScheme) {
    setState(() {
      _colorScheme = newScheme;
    });
    widget.onColorSchemeChanged(_colorScheme);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: _isDarkMode ? CupertinoColors.black : CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: _isDarkMode ? CupertinoColors.darkBackgroundGray : CupertinoColors.white,
        middle: Text(
          'Appearance Settings',
          style: TextStyle(
            color: widget.colorScheme.primary,
            decoration: TextDecoration.none,
            decorationColor: CupertinoColors.transparent,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: _isDarkMode ? CupertinoColors.white : CupertinoColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.bell, color: _isDarkMode ? CupertinoColors.white : CupertinoColors.black),
          onPressed: () {},
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.activeGreen,
                ),
                child: SvgPicture.asset(
                  'assets/appearancePageBg.svg',
                  width: 220,
                  height: 220,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'CHOOSE A STYLE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                  decoration: TextDecoration.none,
                  decorationColor: CupertinoColors.transparent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Would you like to change appearance?\nCustomize your interface',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: _isDarkMode ? CupertinoColors.lightBackgroundGray : CupertinoColors.darkBackgroundGray,
                  decoration: TextDecoration.none,
                  decorationColor: CupertinoColors.transparent,
                ),
              ),
              const SizedBox(height: 20),
              CupertinoSlidingSegmentedControl<bool>(
                groupValue: _isDarkMode,
                backgroundColor: _isDarkMode ? CupertinoColors.darkBackgroundGray : CupertinoColors.lightBackgroundGray,
                thumbColor: _isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                children: {
                  false: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(CupertinoIcons.sun_max_fill, color: _isDarkMode ? CupertinoColors.white : CupertinoColors.white),
                  ),
                  true: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(CupertinoIcons.moon_fill, color: _isDarkMode ? CupertinoColors.black : CupertinoColors.white),
                  ),
                },
                onValueChanged: (value) {
                  if (value != null) {
                    _toggleTheme(value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}







