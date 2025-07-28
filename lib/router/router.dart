import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../pages/apps/sensor/sensor_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/home/home_page.dart';
import '../../../pages/auth/auth_page.dart';
import '../../../pages/auth/register_page.dart';
import '../../../pages/message/message_page.dart';
import '../../../pages/person/person_page.dart';
import '../../../pages/video/video_page.dart';
import '../../../router/routes/tab_shell_route.dart';


class AppRouter{
  static final GoRouter instance = _buildRouter();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static GoRouter _buildRouter(){
    return GoRouter(
      navigatorKey: navigatorKey,
      observers: [],
      initialLocation: '/auth',
      routes: [
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        TabShellRoute.basic(
          routeTabs: [
            RouteTab(
              title: '首页',
              icon: TDIcons.home,
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
            RouteTab(
              title: '视频',
              icon: TDIcons.video,
              path: '/video',
              builder: (context, state) => const VideoPage(),
            ),
            RouteTab(
              title: '消息',
              icon: TDIcons.chat,
              path: '/message',
              builder: (context, state) => const MessagePage(),
            ),
            RouteTab(
              title: '我的',
              icon: TDIcons.user_list,
              path: '/person',
              builder: (context, state) => const PersonPage(),
            )
          ]
        ),

        GoRoute(
          path: '/apps/sensor',
          builder: (context, state) => const SensorPage()
        ),
      ],
    );
  }
}