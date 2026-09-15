import 'dart:async';
import 'dart:math';

import 'package:first_app/models/sensor_model.dart';

class VirtualSensorService {
  static final VirtualSensorService _instance =
      VirtualSensorService._internal();

  factory VirtualSensorService() => _instance;

  VirtualSensorService._internal();

  Timer? _timer;

  final Random _random = Random();

  SensorData _currentData = SensorData(
    temperature: 28,
    humidity: 75,
    soilMoisture: 65,
    soilPH: 6.5,
    lightIntensity: 700,
    windSpeed: 4,
    rainProbability: 20,
    timestamp: DateTime.now(),
  );

  SensorData get currentData => _currentData;

  //--------------------------------------------------

  void startSimulation(Function(SensorData) onDataGenerated) {
    stopSimulation();

    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      _generateData();

      onDataGenerated(_currentData);
    });

    _generateData();

    onDataGenerated(_currentData);
  }

  //--------------------------------------------------

  void stopSimulation() {
    _timer?.cancel();
  }

  //--------------------------------------------------

  void _generateData() {
    double temperature = _updateValue(_currentData.temperature, 24, 36, 0.8);

    double humidity = _updateValue(_currentData.humidity, 55, 95, 2);

    double soil = _updateValue(_currentData.soilMoisture, 30, 90, 2.5);

    double ph = _updateValue(_currentData.soilPH, 5.5, 7.5, 0.08);

    double light = _updateValue(_currentData.lightIntensity, 200, 1000, 35);

    double wind = _updateValue(_currentData.windSpeed, 1, 12, 0.7);

    double rain = _updateValue(_currentData.rainProbability, 0, 100, 6);

    _currentData = SensorData(
      temperature: double.parse(temperature.toStringAsFixed(1)),
      humidity: double.parse(humidity.toStringAsFixed(1)),
      soilMoisture: double.parse(soil.toStringAsFixed(1)),
      soilPH: double.parse(ph.toStringAsFixed(2)),
      lightIntensity: double.parse(light.toStringAsFixed(0)),
      windSpeed: double.parse(wind.toStringAsFixed(1)),
      rainProbability: double.parse(rain.toStringAsFixed(0)),
      timestamp: DateTime.now(),
    );
  }

  //--------------------------------------------------

  double _updateValue(
      double current, double min, double max, double variation) {
    current += (_random.nextDouble() * 2 - 1) * variation;

    if (current < min) current = min;

    if (current > max) current = max;

    return current;
  }
}
