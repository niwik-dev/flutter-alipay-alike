import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

part 'app_logo.g.dart';

@swidget
Widget appLogo(){
  return Wrap(
    direction: Axis.vertical,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      SizedBox(
        width: 128,
        height: 128,
        child: ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade200,
                Colors.blue,
                Colors.blueAccent.shade100,
                Colors.blueAccent.shade200,
                Colors.blueAccent.shade400,
                Colors.blueAccent.shade700
              ],
            ).createShader(bounds);
          },
          child: const FlutterLogo()
        ),
      ),
      const TDText(
        '贝小讯',
        style: TextStyle(
          fontSize: 36,
          color: Colors.black,
        ),
      ),
      const TDText(
        'PalMessage',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    ],
  );
}