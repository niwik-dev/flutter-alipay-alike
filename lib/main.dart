import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_kit/media_kit.dart';

import 'router/router.dart';
import 'utils/window.dart';

void main(){
  runApp(const StandardApp());
}

class StandardApp extends StatelessWidget {
  const StandardApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    WindowUtils.initialize();
    MediaKit.ensureInitialized();

    return ScreenUtilInit(
      designSize: const Size(1080, 2400),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ProviderScope(
        child: MaterialApp.router(
          title: 'Standard App',
          debugShowCheckedModeBanner: false,
          color: Colors.white,
          theme: ThemeData(
            fontFamily: 'FC',
            useMaterial3: false,
            colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(8, 104, 255, 1),
            ),
          ),
          routerConfig: AppRouter.instance,
        ),
      ),
    );
  }
}
