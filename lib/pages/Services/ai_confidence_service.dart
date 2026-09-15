import '/models/sensor_model.dart';

class AIConfidenceService {

  static double calculate(SensorData s) {

    double confidence = 100;

    confidence -= (s.temperature - 28).abs() * 0.8;

    confidence -= (s.humidity - 70).abs() * 0.30;

    confidence -= (s.soilMoisture - 60).abs() * 0.35;

    confidence -= (s.soilPH - 6.8).abs() * 6;

    confidence -= (s.windSpeed - 10).abs() * 0.7;

    confidence -= s.rainProbability * 0.10;

    confidence = confidence.clamp(60, 99);

    return confidence;
  }

  static String status(double score) {

    if (score >= 90) {
      return "Excellent";
    }

    if (score >= 80) {
      return "High";
    }

    if (score >= 70) {
      return "Moderate";
    }

    return "Low";
  }

}