import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../config/tab_bar/bottom_tab_bar.dart';
import '../router/router.dart';
import '../router/routes/tab_shell_route.dart';
import '../store/tab_bar/tab_bar_state_store.dart';

part 'tab_page_shell.g.dart';


@hcwidget
Widget tabPageShell(
  BuildContext context,
  WidgetRef ref,
  {
    required GoRouterState state,
    required Widget body,
    required List<RouteTab> routeTabs
  }
) {
  final selectedTabIndex = useState(0);
  var tabBarState = ref.watch(tabBarStateStoreProvider);

  List<TDBottomTabBarTabConfig> buildTabs(context, state, child){
    return routeTabs.map((RouteTab routeTab) {
      int index = routeTabs.indexOf(routeTab);
      return BottomTabBarTabConfigFactory.basic(
        context: context,
        tabText: routeTab.title,
        icon: routeTab.icon,
        isDark: tabBarState.isDark,
        onTap: () {
          selectedTabIndex.value = index;
          AppRouter.instance.go(routeTab.path);
        },
      );
    }).toList();
  }

  return SafeArea(
    child: Material(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: body,
          ),
          tabBarState.isHidden?
          const SizedBox.shrink():
          SizedBox(
            height: 80,
            child: TDBottomTabBar(
              barHeight: 80,
              currentIndex: selectedTabIndex.value,
              selectedBgColor: Colors.transparent,
              backgroundColor: tabBarState.isDark? Colors.black :Colors.white,
              TDBottomTabBarBasicType.iconText,
              navigationTabs: buildTabs(context, state, body)
            )
          )
        ],
      ),
    )
  );
}