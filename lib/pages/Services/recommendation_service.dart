import 'package:first_app/models/sensor_model.dart';

class RecommendationResult {
  final String weather;
  final String fieldStatus;
  final String recommendation;
  final String alert;
  final bool pumpOn;

  RecommendationResult({
    required this.weather,
    required this.fieldStatus,
    required this.recommendation,
    required this.alert,
    required this.pumpOn,
  });
}

class RecommendationService {
  static RecommendationResult generate(SensorData sensor) {
    String weather = _detectWeather(sensor);

    String recommendation = "";
    String alert = "No abnormal condition detected.";
    String fieldStatus = "Healthy";

    bool pump = false;

    //-----------------------------
    // Soil Moisture
    //-----------------------------

    if (sensor.soilMoisture < 30) {
      recommendation =
          "Soil moisture is critically low. Irrigation is recommended immediately.";

      alert = "Critical soil moisture detected.";

      pump = true;

      fieldStatus = "Critical";
    }

    else if (sensor.soilMoisture < 45) {
      recommendation =
          "Soil moisture is slightly low. Consider irrigation soon.";

      fieldStatus = "Moderate";
    }

    //-----------------------------
    // Temperature
    //-----------------------------

    else if (sensor.temperature > 35) {
      recommendation =
          "High temperature detected. Monitor crop heat stress.";

      alert = "Heat Stress Warning.";

      fieldStatus = "Warning";
    }

    //-----------------------------
    // Humidity
    //-----------------------------

    else if (sensor.humidity > 90) {
      recommendation =
          "Humidity is very high. Risk of fungal disease.";

      alert = "High Disease Risk.";

      fieldStatus = "Warning";
    }

    //-----------------------------
    // Soil pH
    //-----------------------------

    else if (sensor.soilPH < 5.5) {
      recommendation =
          "Soil pH is acidic. Liming is recommended.";

      fieldStatus = "Moderate";
    }

    else if (sensor.soilPH > 7.5) {
      recommendation =
          "Soil pH is alkaline. Soil treatment is recommended.";

      fieldStatus = "Moderate";
    }

    //-----------------------------
    // Rain
    //-----------------------------

    else if (sensor.rainProbability > 80) {
      recommendation =
          "Heavy rainfall is expected. Avoid irrigation.";

      alert = "Rain Expected.";

      pump = false;
    }

    //-----------------------------
    // Healthy
    //-----------------------------

    else {
      recommendation =
          "Field conditions are optimal. Continue regular monitoring.";

      fieldStatus = "Healthy";

      alert = "No abnormal condition detected.";
    }

    return RecommendationResult(
      weather: weather,
      fieldStatus: fieldStatus,
      recommendation: recommendation,
      alert: alert,
      pumpOn: pump,
    );
  }

  //------------------------------------------------------------

  static String _detectWeather(SensorData sensor) {
    if (sensor.rainProbability > 80) {
      return "Heavy Rain";
    }

    if (sensor.rainProbability > 60) {
      return "Rain";
    }

    if (sensor.humidity > 80) {
      return "Cloudy";
    }

    return "Sunny";
  }
}