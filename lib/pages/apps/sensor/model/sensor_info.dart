class SensorInfo{
  final String deviceType;

  final String deviceName;
  // 温度
  final double? temperature;
  // 湿度
  final int? humidity;
  // 电压
  final double? voltage;

  SensorInfo({
    required this.deviceType,
    required this.deviceName,
    this.temperature,
    this.humidity,
    this.voltage,
  });
}