import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../components/gradient/presets.dart';
import '../../../components/icons/gradient_icon.dart';
import '../../../pages/apps/sensor/service/universal/sensor_service.dart';
import '../../../pages/apps/sensor/service/windows/sensor_service.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';



class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {

  late var sensorService;

  bool keepRefresh = false;

  @override
  void initState() {
    if(Platform.isWindows){
      sensorService = WinSensorService();
    }else{
      sensorService = UniSensorService();
    }

    sensorService.init(
      onUpdate: (){
        if(mounted){
          setState(() {
          });
        }
      },
      onError: (error){
        TDToast.showFail('蓝牙错误:$error', context: context);
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    sensorService.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TDNavBar(
        title: '传感器',
      ),
      body: sensorService.isAdapterOkay()?
      SizedBox.expand(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                shrinkWrap: true,
                children: [
                  if(sensorService.isScanning)
                    const LinearProgressIndicator(),

                  for (var sensorInfo in sensorService.sensorInfoMap.values)
                    ListTile(
                      tileColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      leading: const GradientIcon(
                        Icons.sensors,
                        size: 48,
                        gradient: IconGradientPresets.tech,
                      ),
                      title: Text(sensorInfo.deviceType),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('名称：${sensorInfo.deviceName}'),
                          Text('温度：${sensorInfo.temperature ?? '-- '}°C'),
                          Text('湿度：${sensorInfo.humidity ?? '-- ' }%'),
                          Text('电压：${sensorInfo.voltage ?? '-- ' }V'),
                        ],
                      ),
                      trailing: TDButton(
                        theme: TDButtonTheme.danger,
                        child:  const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            TDText(
                              '断开连接',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        onTap: () async {
                          sensorService.removeDevice(sensorInfo.deviceName);

                          if(mounted){
                            setState(() {
                            });
                          }
                        },
                      ),
                      onTap: () async {

                      },
                    )
                ]
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TDButton(
                  disabled: keepRefresh,
                  theme: TDButtonTheme.primary,
                  child: keepRefresh?
                  const Row(
                    children: [
                      TDLoading(
                        size: TDLoadingSize.large,
                      ),
                      SizedBox(width: 8),
                      TDText(
                        '搜索中...',
                        textColor: Colors.white,
                      )
                    ],
                  )
                  :const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      TDText(
                        '搜索设备',
                        textColor: Colors.white,
                      )
                    ],
                  ),
                  onTap: () async {
                    setState(() {
                      keepRefresh = true;
                    });

                    Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
                      sensorService.fetchSensorData(
                        onUpdate: (){
                          setState(() {});
                        },
                        onDeviceFound: (){
                          TDToast.showSuccess('发现设备', context: context);
                        }
                      );
                      if(sensorService.hasDeviceFound()){
                        timer.cancel();
                        keepRefresh = false;
                      }
                    });
                  }
                ),
                const SizedBox(width: 16),
                TDButton(
                  type: TDButtonType.fill,
                  theme: TDButtonTheme.danger,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.stop,
                        color: Colors.white,
                      ),
                      TDText(
                        '停止搜索',
                        textColor: Colors.white
                      )
                    ]
                  ),
                  onTap: () async {
                    sensorService.stopScan();
                  },
                )
              ],
            )
          ],
        )
      ) : BluetoothOffHint(),
    );
  }
}

class BluetoothOffHint extends StatefulWidget {
  const BluetoothOffHint({super.key});

  @override
  State<BluetoothOffHint> createState() => _BluetoothOffHintState();
}

class _BluetoothOffHintState extends State<BluetoothOffHint> {

  late var sensorService;

  @override
  void initState() {
    if(Platform.isWindows){
      sensorService = WinSensorService();
    }else{
      sensorService = UniSensorService();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox.expand(
          child: Column(
            children: [
              const Icon(
                Icons.bluetooth_disabled,
                size: 200,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const TDText(
                "蓝牙不可用！",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              const TDText(
                "此功能需要蓝牙通讯，请考虑允许蓝牙权限并开启",
                textColor: Colors.black45,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TDButton(
                  theme: TDButtonTheme.primary,
                  onTap: () async {
                    await sensorService.turnOnAdapter();
                  },
                  icon: TDIcons.bluetooth,
                  child: const TDText(
                    "打开蓝牙",
                    textColor: Colors.white,
                  )
              )
            ],
          ),
        )
    );
  }
}