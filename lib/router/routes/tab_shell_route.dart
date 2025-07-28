import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../config/tab_bar/bottom_tab_bar.dart';
import '../../shell/tab_page_shell.dart';

class RouteTab{
  String title;
  IconData icon;
  String path;
  GoRouterWidgetBuilder? builder;
  GoRouterPageBuilder? pageBuilder;

  RouteTab({
    required this.title,
    required this.icon,
    required this.path,
    this.builder,
    this.pageBuilder
  });
}

class TabShellRoute {

  static ShellRoute basic(
      {
        required List<RouteTab> routeTabs
      }
  ) {

    List<GoRoute> buildRoute(){
      return routeTabs.map((RouteTab routeTab) {
        return GoRoute(
          path: routeTab.path,
          builder: routeTab.builder,
          pageBuilder: routeTab.pageBuilder,
        );
      }).toList();
    }

    return ShellRoute(
      builder: (context, state, child) {
        return TabPageShell(
          state: state,
          body: child,
          routeTabs: routeTabs,
        );
      },
      routes: buildRoute(),
    );
  }
}