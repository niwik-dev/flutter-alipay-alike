import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  const VerticalIconButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.spacing = 4,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  final Widget text;

  final Widget icon;

  final void Function() onTap;

  final double spacing;

  final Color backgroundColor;

  @override
  Widget build(BuildContext _context){
    {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              SizedBox(height: spacing),
              text
            ],
          ),
        ),
      );
    }
  }
}