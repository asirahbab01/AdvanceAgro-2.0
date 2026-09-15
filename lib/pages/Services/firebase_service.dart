import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/sensor_model.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //------------------------------------------------

  static Future<void> uploadSensorData(
      SensorData sensorData) async {
    await _db
        .collection("sensor_data")
        .doc("current")
        .set(sensorData.toMap());
  }

  //------------------------------------------------

  static Stream<DocumentSnapshot<Map<String, dynamic>>> sensorStream() {
    return _db
        .collection("sensor_data")
        .doc("current")
        .snapshots();
  }
}

