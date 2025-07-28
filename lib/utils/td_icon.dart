import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TDIconUtils{

  static IconData getFilledIcon(IconData icon){
    // 根据value找到对应的key
    String iconName = TDIcons.all.keys.firstWhere(
          (key) => TDIcons.all[key] == icon
    );

    String filledIconName = "${iconName}_filled";

    return TDIcons.all[filledIconName]!;
  }

  static IconData randomTDIcon(){
    return TDIcons.all.values.elementAt(
      Random().nextInt(TDIcons.all.values.length)
    );
  }

  static IconData randomTDFilledIcon(){
    List<String> filledIconsKeys = TDIcons.all.keys.where(
        (key) => key.contains('_filled')
    ).toList();

    List<IconData> filledIcons = filledIconsKeys.map(
          (value) => TDIcons.all[value]!
    ).toList();

    return filledIcons.elementAt(
        Random().nextInt(filledIcons.length)
    );
  }
}