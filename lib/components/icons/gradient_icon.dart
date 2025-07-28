import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'gradient_icon.g.dart';

@swidget
Widget gradientIcon(BuildContext context,IconData icon,{
  double size = 24,
  required Gradient gradient,
}) {
  return ShaderMask(
    shaderCallback: (Rect bounds) {
      return gradient.createShader(bounds);
    },
    child: Icon(
      icon,
      size: size,
      color: Colors.white,
    ),
  );
}