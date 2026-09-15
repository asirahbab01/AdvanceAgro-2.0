import 'package:first_app/models/sensor_model.dart';

class FieldHealthService {
  static double calculate(SensorData sensor) {
    double score = 100;

    //---------------- Temperature ----------------//

    if (sensor.temperature < 18 || sensor.temperature > 38) {
      score -= 20;
    } else if (sensor.temperature < 22 || sensor.temperature > 34) {
      score -= 10 +
          (sensor.temperature < 22
              ? (22 - sensor.temperature) * 0.5
              : (sensor.temperature - 34) * 0.5);
    } else {
      score -= (sensor.temperature - 28).abs() * 0.25;
    }

    //---------------- Humidity ----------------//

    if (sensor.humidity < 35 || sensor.humidity > 90) {
      score -= 15;
    } else if (sensor.humidity < 50 || sensor.humidity > 80) {
      score -= 8 +
          (sensor.humidity < 50
              ? (50 - sensor.humidity) * 0.15
              : (sensor.humidity - 80) * 0.15);
    } else {
      score -= (sensor.humidity - 65).abs() * 0.08;
    }

    //---------------- Soil Moisture ----------------//

    if (sensor.soilMoisture < 25 || sensor.soilMoisture > 90) {
      score -= 25;
    } else if (sensor.soilMoisture < 40 || sensor.soilMoisture > 75) {
      score -= 12 +
          (sensor.soilMoisture < 40
              ? (40 - sensor.soilMoisture) * 0.2
              : (sensor.soilMoisture - 75) * 0.2);
    } else {
      score -= (sensor.soilMoisture - 60).abs() * 0.08;
    }

    //---------------- Soil pH ----------------//

    if (sensor.soilPH < 5.0 || sensor.soilPH > 8.5) {
      score -= 18;
    } else if (sensor.soilPH < 5.8 || sensor.soilPH > 7.5) {
      score -= 8 +
          (sensor.soilPH < 5.8
              ? (5.8 - sensor.soilPH) * 2
              : (sensor.soilPH - 7.5) * 2);
    } else {
      score -= (sensor.soilPH - 6.5).abs() * 0.8;
    }

    //---------------- Light ----------------//

    if (sensor.lightIntensity < 1200) {
      score -= 10 + (1200 - sensor.lightIntensity) * 0.002;
    }

    //---------------- Wind ----------------//

    if (sensor.windSpeed > 25) {
      score -= 10;
    } else {
      score -= sensor.windSpeed * 0.03;
    }

    //---------------- Rain ----------------//

    if (sensor.rainProbability > 85) {
      score -= 8;
    } else {
      score -= sensor.rainProbability * 0.01;
    }

    if (score < 0) score = 0;
    return score;
  }

  static String status(double score) {
    if (score >= 90) return "Excellent";

    if (score >= 75) return "Healthy";

    if (score >= 60) return "Moderate";

    if (score >= 40) return "Poor";

    return "Critical";
  }
}
