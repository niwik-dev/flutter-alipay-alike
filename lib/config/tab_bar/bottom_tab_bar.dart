import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../components/icons/gradient_icon.dart';
import '../../utils/td_icon.dart';

class BottomTabBarTabConfigFactory {
  static TDBottomTabBarTabConfig basic(
    {
      required BuildContext context,
      required String tabText,
      required IconData icon,
      required GestureTapCallback onTap,
      required bool isDark
    }
  ){
    Color? brandColorPrimary = TDTheme.of(context).colorMap["brandColor7"];

    return TDBottomTabBarTabConfig(
        tabText: tabText,
        unselectTabTextStyle: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
          color: isDark?Colors.white:Colors.black,
        ),
        selectTabTextStyle: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          color: isDark?Colors.white:brandColorPrimary,
          fontWeight: FontWeight.w600
        ),
        unselectedIcon: Icon(
          icon,
          color: isDark?Colors.white:Colors.black,
          size: 28
        ),
        selectedIcon: GradientIcon(
          TDIconUtils.getFilledIcon(icon),
          size: 32,
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(36,141,254, 1),
                Color.fromRGBO(6,101,255, 1),
              ]
          ),
        ),
        badgeConfig: BadgeConfig(
          showBadge:true,
          tdBadge: const TDBadge(
            TDBadgeType.square,
            count: '0',
            showZero: false,
          ),
        ),
        onTap: onTap
    );
  }
}