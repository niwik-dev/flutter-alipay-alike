import 'dart:async';

import 'package:flutter_blue_plus_windows/flutter_blue_plus_windows.dart';

import '../../model/sensor_info.dart';

class WinSensorService{
  // 单例模式
  static final WinSensorService _instance = WinSensorService._internal();
  factory WinSensorService() {
    return _instance;
  }
  WinSensorService._internal();

  BluetoothAdapterState adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> adapterStateStateSubscription;

  Map<String,BluetoothDevice> targetDevices = {};
  Map<String,SensorInfo> sensorInfoMap = {};
  Map<String,Timer> deviceTimerMap = {};

  List<BluetoothDevice> systemDevices = [];
  List<ScanResult> scanResults = [];
  bool isScanning = false;
  late StreamSubscription<List<ScanResult>> scanResultsSubscription;
  late StreamSubscription<bool> isScanningSubscription;

  void init({
    required Function onUpdate,
    required Function(Exception e) onError
  }){
    adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      adapterState = state;
      onUpdate();
    });

    scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      scanResults = results;
      onUpdate();
    }, onError: (e){});

    isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      isScanning = state;
      onUpdate();
    });
  }

  void dispose(){
    adapterStateStateSubscription.cancel();
    scanResultsSubscription.cancel();
    isScanningSubscription.cancel();

    targetDevices.clear();
    sensorInfoMap.clear();
    deviceTimerMap.clear();
    for(var deviceTimer in deviceTimerMap.values){
      deviceTimer.cancel();
    }
    for(var device in targetDevices.values){
      device.disconnect();
    }

    scanResults.clear();
  }

  void removeDevice(String deviceName){
    final device = targetDevices[deviceName];
    if (device != null) {
      device.disconnect();
      targetDevices.remove(deviceName);
      sensorInfoMap.remove(deviceName);
      if(deviceTimerMap.containsKey(deviceName)){
        deviceTimerMap[deviceName]?.cancel();
        deviceTimerMap.remove(deviceName);
      }
    }
  }

  bool hasDeviceFound(){
    return targetDevices.isNotEmpty;
  }

  bool isAdapterOkay(){
    return adapterState == BluetoothAdapterState.on
        || adapterState == BluetoothAdapterState.unknown;
  }

  Future<void> turnOnAdapter() async {
    await FlutterBluePlus.turnOn();
  }

  Future<void> startScan({
    required Function onUpdate,
  }) async {
    FlutterBluePlus.systemDevices([]).then((systemDevices){
      this.systemDevices = systemDevices;
    });
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  Future<void> parseServicesFromDevice({
    required BluetoothDevice device,
    required Function onUpdate
  }) async {
    List<BluetoothService> services;
    if(device.servicesList.isEmpty){
      services = await device.discoverServices();
    }else{
      services = device.servicesList;
    }
    for (var service in services) {
      String serviceUuid = service.serviceUuid.str;
      if(serviceUuid.startsWith("ebe0ccb0") && serviceUuid.endsWith("7da3a6")){
        var characteristics = service.characteristics;
        for (var characteristic in characteristics) {
          String characteristicUuid = characteristic.uuid.str;
          if(characteristicUuid.startsWith("ebe0ccc1") && characteristicUuid.endsWith("7da3a6")){

            if(characteristic.isNotifying) {
              characteristic.onValueReceived.listen((value) {
                // 温度
                double temperature = (value[1] << 8 | value[0]) / 100;
                // 湿度
                int humidity = value[2];
                // 电压
                double voltage = (value[4] << 8 | value[3]) / 1000;

                sensorInfoMap[device.advName] = SensorInfo(
                  deviceType: "米家温湿计",
                  deviceName: device.advName,
                  temperature: temperature,
                  humidity: humidity,
                  voltage: voltage,
                );
                onUpdate();
              });
            }else{
              // 定时器获取
              if(!deviceTimerMap.containsKey(device.advName)){
                final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
                  characteristic.read().then((value) {
                    // 温度
                    double temperature = (value[1] << 8 | value[0]) / 100;
                    // 湿度
                    int humidity = value[2];
                    // 电压
                    double voltage = (value[4] << 8 | value[3]) / 1000;

                    sensorInfoMap[device.advName] = SensorInfo(
                      deviceType: "米家温湿计",
                      deviceName: device.advName,
                      temperature: temperature,
                      humidity: humidity,
                      voltage: voltage,
                    );

                    onUpdate();
                  });
                });
                deviceTimerMap[device.advName] = timer;
              }
            }
          }
        }
      }
    }
  }

  Future<void> fetchSensorData({
    required Function onUpdate,
    required Function onDeviceFound
  }) async {
    if(!isScanning || targetDevices.isEmpty){
      startScan(onUpdate: onUpdate);
    }

    do{
      for (var device in FlutterBluePlus.connectedDevices) {
        if(device.advName.endsWith('3MMC')){
          if (!targetDevices.containsKey(device.advName)){
            targetDevices[device.advName] = device;
          }
          break;
        }
      }

      for (var scanResult in scanResults) {
        final device = scanResult.device;
        if(device.advName.endsWith('3MMC')){
          if (!targetDevices.containsKey(device.advName)){
            targetDevices[device.advName] = device;
          }
          break;
        }
      }
    }while(false);

    if(targetDevices.isNotEmpty){
      onDeviceFound();
    }

    for (var device in targetDevices.values) {
      sensorInfoMap[device.advName] = SensorInfo(
        deviceType: "米家温湿计",
        deviceName: device.advName,
      );

      if(!device.isConnected){
        device.connect().then((_) async {
          await parseServicesFromDevice(device: device, onUpdate: onUpdate);
        });
      }else{
        await parseServicesFromDevice(device: device,onUpdate: onUpdate);
      }
    }
  }
}