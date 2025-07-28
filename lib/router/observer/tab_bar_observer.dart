import 'package:flutter/material.dart';

class TabBarRouterObserver extends RouteAware {
  @override
  void didPush() {
    super.didPush();
    print('didPush');
  }
}