// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_page_shell.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class TabPageShell extends HookConsumerWidget {
  const TabPageShell({
    Key? key,
    required this.state,
    required this.body,
    required this.routeTabs,
  }) : super(key: key);

  final GoRouterState state;

  final Widget body;

  final List<RouteTab> routeTabs;

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      tabPageShell(
        _context,
        _ref,
        state: state,
        body: body,
        routeTabs: routeTabs,
      );
}
