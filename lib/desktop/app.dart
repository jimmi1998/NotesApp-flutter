import 'package:animations/animations.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:notesapp_flutter/common/constants.dart';
import 'package:notesapp_flutter/common/string_values.dart';
import 'package:notesapp_flutter/desktop/pages/archive_page.dart';
import 'package:notesapp_flutter/desktop/pages/home_page.dart';
import 'package:notesapp_flutter/desktop/pages/search_page.dart';
import 'package:notesapp_flutter/desktop/pages/settings_page.dart';
import 'package:notesapp_flutter/widgets/topbar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:notesapp_flutter/helpers/globals.dart' as globals;

class ScrawlDesktop extends StatefulWidget {
  const ScrawlDesktop({Key? key}) : super(key: key);

  @override
  _ScrawlDesktopState createState() => _ScrawlDesktopState();
}

class _ScrawlDesktopState extends State<ScrawlDesktop> {
  final _pageList = <Widget>[
    new HomePage(),
    new ArchivePage(),
    new SearchPage(),
    new DSettingsPage(),
  ];
  int _page = 0;
  bool isExtended = false;

  Widget menuItem(String title, int index, IconData? icon) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = (globals.themeMode == ThemeMode.dark ||
        (brightness == Brightness.dark &&
            globals.themeMode == ThemeMode.system));
    return Tooltip(
      message: title,
      child: Icon(
        icon,
        color: _page == index
            ? FlexColor.jungleDarkPrimary
            : (darkModeOn ? Colors.white : Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = (globals.themeMode == ThemeMode.dark ||
        (brightness == Brightness.dark &&
            globals.themeMode == ThemeMode.system));
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: darkModeOn ? kSecondaryDark : Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(children: [
              kVSpace,
              TextButton(
                child: menuItem(kLabelNotes, 0, Iconsax.note),
                onPressed: () {
                  setState(() {
                    _page = 0;
                  });
                },
              ),
              kVSpace,
              TextButton(
                child: menuItem(kLabelArchive, 1, Iconsax.archive),
                onPressed: () {
                  setState(() {
                    _page = 1;
                  });
                },
              ),
              kVSpace,
              TextButton(
                child: menuItem(kLabelSearch, 2, Iconsax.search_normal),
                onPressed: () {
                  setState(() {
                    _page = 2;
                  });
                },
              ),
              kVSpace,
              TextButton(
                child: menuItem(kLabelSettings, 3, Iconsax.menu),
                onPressed: () {
                  setState(() {
                    _page = 3;
                  });
                },
              ),
            ]),
          ),
          Expanded(
            child: Column(
              children: [
                WindowTopBar(),
                Expanded(
                  child: PageTransitionSwitcher(
                    transitionBuilder: (child, animation, secondaryAnimation) {
                      return FadeThroughTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      );
                    },
                    child: _pageList[_page],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}