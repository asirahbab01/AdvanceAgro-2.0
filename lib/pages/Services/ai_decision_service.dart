import 'package:first_app/models/sensor_model.dart';

class AIDecision {

  final String irrigation;

  final String diseaseRisk;

  final String stress;

  final String alert;

  AIDecision({

    required this.irrigation,

    required this.diseaseRisk,

    required this.stress,

    required this.alert,

  });

}

class AIDecisionService {

  static AIDecision analyze(
      SensorData data){

    //---------------- Irrigation ----------------

    String irrigation;

    if(data.soilMoisture<40){

      irrigation="High Priority";

    }

    else if(data.soilMoisture<60){

      irrigation="Moderate";

    }

    else{

      irrigation="Not Required";

    }

    //---------------- Disease ----------------

    String disease;

    if(data.humidity>82 &&
        data.temperature>30){

      disease="High";

    }

    else if(data.humidity>70){

      disease="Moderate";

    }

    else{

      disease="Low";

    }

    //---------------- Stress ----------------

    String stress;

    if(data.temperature>35){

      stress="High Heat Stress";

    }

    else if(data.soilMoisture<40){

      stress="Water Stress";

    }

    else{

      stress="Normal";

    }

    //---------------- Alert ----------------

    String alert;

    if(stress!="Normal"){

      alert=
          "Critical: Immediate field inspection recommended.";

    }

    else{

      alert=
          "Field conditions are stable.";

    }

    return AIDecision(

      irrigation: irrigation,

      diseaseRisk: disease,

      stress: stress,

      alert: alert,

    );

  }

}