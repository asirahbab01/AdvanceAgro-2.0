import 'package:cloud_firestore/cloud_firestore.dart';
class SensorData {
  final double temperature;
  final double humidity;
  final double soilMoisture;
  final double soilPH;
  final double lightIntensity;
  final double windSpeed;
  final double rainProbability;
  final DateTime timestamp;

  SensorData({
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
    required this.soilPH,
    required this.lightIntensity,
    required this.windSpeed,
    required this.rainProbability,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "temperature": temperature,
      "humidity": humidity,
      "soilMoisture": soilMoisture,
      "soilPH": soilPH,
      "lightIntensity": lightIntensity,
      "windSpeed": windSpeed,
      "rainProbability": rainProbability,
      "timestamp": FieldValue.serverTimestamp(),
  };
  }

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      temperature: (map["temperature"] as num).toDouble(),
      humidity: (map["humidity"] as num).toDouble(),
      soilMoisture: (map["soilMoisture"] as num).toDouble(),
      soilPH: (map["soilPH"] as num).toDouble(),
      lightIntensity: (map["lightIntensity"] as num).toDouble(),
      windSpeed: (map["windSpeed"] as num).toDouble(),
      rainProbability: (map["rainProbability"] as num).toDouble(),
      timestamp: (map["timestamp"] as Timestamp).toDate(),

    );
  }
}