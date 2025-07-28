import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowUtils {
  static Future<void> initialize() async {
    bool isPC = !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);
    if(!isPC){
      return;
    }
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
        size: Size(432,960),
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
        alwaysOnTop: true
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setResizable(false);
      await windowManager.show();
      await windowManager.focus();
      await windowManager.blur();
    });

  }
}