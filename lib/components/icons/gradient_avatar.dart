import 'package:flutter/cupertino.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'gradient_avatar.g.dart';

@swidget
Widget gradientCircleAvatar({
  double radius = 52,
  required Gradient gradient,
  required Widget child,
}){
  return Container(
    width: radius,
    height: radius,
    decoration: BoxDecoration(
      gradient: gradient,
      shape: BoxShape.circle
    ),
    child: Center(
      child: child,
    ),
  );
}