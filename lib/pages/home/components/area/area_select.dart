import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class AreaSelect extends HookConsumerWidget {
  const AreaSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    var currentArea = useState<String>("北京");
    var currentWeather = useState<String>("晴");
    var currentTemperature = useState<String>("25");

    return GestureDetector(
      onTap: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TDText(
                currentArea.value,
                textColor: Colors.white,
              ),
              Icon(
                TDIcons.chevron_down,
                color: Colors.white,
              )
            ],
          ),
          TDText(
            "${currentWeather.value} ${currentTemperature.value}℃",
            font: TDTheme.of(context).fontBodySmall,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}