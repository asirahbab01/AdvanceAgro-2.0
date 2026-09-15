import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/sensor_model.dart';
import '../widgets/alert_card.dart';
import '../widgets/crop_info_card.dart';
import '../widgets/field_health_card.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/sensor_card.dart';
import 'Services/ai_decision_service.dart';
import 'Services/field_health_service.dart';
import 'Services/firebase_service.dart';
import 'Services/recommendation_service.dart';
import 'Services/virtual_sensor_service.dart';
import 'weather_service.dart';

class SmartFieldDashboard extends StatefulWidget {
  const SmartFieldDashboard({super.key});

  @override
  State<SmartFieldDashboard> createState() => _SmartFieldDashboardState();
}

class _SmartFieldDashboardState extends State<SmartFieldDashboard> {
  final VirtualSensorService sensor = VirtualSensorService();
  DateTime plantedDate = DateTime.now();
  double? _weatherTemperature;

  @override
  void initState() {
    super.initState();
    sensor.startSimulation((data) async {
      await FirebaseService.uploadSensorData(data);
    });
    _loadWeatherTemperature();
  }

  Future<void> _loadWeatherTemperature() async {
    try {
      final weather = await WeatherServices().fetchCurrentWeather(0, 0);
      if (mounted) {
        setState(() => _weatherTemperature = weather.temperature);
      }
    } catch (_) {
      // Keep using the simulator value when weather access is unavailable.
    }
  }

  @override
  void dispose() {
    sensor.stopSimulation();
    super.dispose();
  }

  Future<void> pickPlantDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: plantedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      setState(() => plantedDate = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseService.sensorStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none ||
            !snapshot.hasData ||
            !snapshot.data!.exists ||
            snapshot.data!.data() == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: Colors.green)),
          );
        }

        final sensorData = SensorData.fromMap(snapshot.data!.data()!);
        final currentData = _weatherTemperature == null
            ? sensorData
            : SensorData(
                temperature: _weatherTemperature!,
                humidity: sensorData.humidity,
                soilMoisture: sensorData.soilMoisture,
                soilPH: sensorData.soilPH,
                lightIntensity: sensorData.lightIntensity,
                windSpeed: sensorData.windSpeed,
                rainProbability: sensorData.rainProbability,
                timestamp: sensorData.timestamp,
              );
        final recommendation = RecommendationService.generate(currentData);
        final decision = AIDecisionService.analyze(currentData);
        final score = FieldHealthService.calculate(currentData);
        final cropSuitability = _cropSuitability(currentData);

        return Scaffold(
          backgroundColor: const Color(0xffF5F7FA),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CropInfoCard(
                  plantedDate: plantedDate,
                  onSelectDate: pickPlantDate,
                ),
                const SizedBox(height: 20),
                FieldHealthCard(
                  score: score,
                  status: FieldHealthService.status(score),
                ),
                const SizedBox(height: 16),
                _ResultsExplanation(
                  status: FieldHealthService.status(score),
                  score: score,
                  diseaseRisk: decision.diseaseRisk,
                  irrigation: decision.irrigation,
                  stress: decision.stress,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Live Sensor Readings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.15,
                  children: [
                    SensorCard(
                      title: 'Temperature',
                      value: '${currentData.temperature.toStringAsFixed(1)} °C',
                      icon: Icons.thermostat,
                      color: Colors.deepOrange,
                    ),
                    SensorCard(
                      title: 'Humidity',
                      value: '${sensorData.humidity.toStringAsFixed(0)} %',
                      icon: Icons.water_drop,
                      color: Colors.blue,
                    ),
                    SensorCard(
                      title: 'Soil Moisture',
                      value: '${sensorData.soilMoisture.toStringAsFixed(0)} %',
                      icon: Icons.grass,
                      color: Colors.green,
                    ),
                    SensorCard(
                      title: 'Soil pH',
                      value: sensorData.soilPH.toStringAsFixed(1),
                      icon: Icons.science,
                      color: Colors.purple,
                    ),
                    SensorCard(
                      title: 'Light',
                      value:
                          '${sensorData.lightIntensity.toStringAsFixed(0)} Lux',
                      icon: Icons.wb_sunny,
                      color: Colors.amber,
                    ),
                    SensorCard(
                      title: 'Wind Speed',
                      value: '${sensorData.windSpeed.toStringAsFixed(1)} km/h',
                      icon: Icons.air,
                      color: Colors.teal,
                    ),
                    SensorCard(
                      title: 'Rain Probability',
                      value:
                          '${sensorData.rainProbability.toStringAsFixed(0)} %',
                      icon: Icons.umbrella,
                      color: Colors.indigo,
                    ),
                    SensorCard(
                      title: 'Crop Suitability',
                      value: '${cropSuitability.toStringAsFixed(0)} %',
                      icon: Icons.agriculture,
                      color: Colors.brown,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                RecommendationCard(
                  recommendation: recommendation.recommendation,
                ),
                const SizedBox(height: 20),
                AlertCard(alert: recommendation.alert),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

double _cropSuitability(SensorData sensor) {
  double score = 100;

  score -= (sensor.temperature - 28).abs() * 2;
  score -= (sensor.humidity - 70).abs() * 0.5;
  score -= (sensor.soilMoisture - 60).abs() * 0.7;
  score -= (sensor.soilPH - 6.5).abs() * 8;
  score -= (sensor.lightIntensity < 500 ? 10 : 0);

  return score.clamp(0, 100);
}

class _ResultsExplanation extends StatelessWidget {
  final String status;
  final double score;
  final String diseaseRisk;
  final String irrigation;
  final String stress;

  const _ResultsExplanation({
    required this.status,
    required this.score,
    required this.diseaseRisk,
    required this.irrigation,
    required this.stress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Field Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Field Condition is $status at ${score.toStringAsFixed(0)}%, based on the current environmental readings.',
            ),
            const SizedBox(height: 4),
            Text(
              'Disease risk: $diseaseRisk. Water action: $irrigation.\nPlant stress: $stress.',
            ),
            const SizedBox(height: 4),
            Text(
              'Check the field before acting if the readings change suddenly.',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
