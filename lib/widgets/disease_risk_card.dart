import 'package:flutter/material.dart';

class DiseaseRiskCard extends StatelessWidget {

  final String risk;

  const DiseaseRiskCard({
    super.key,
    required this.risk,
  });

  Color color(){

    switch(risk){

      case "Low":

        return Colors.green;

      case "Moderate":

        return Colors.orange;

      default:

        return Colors.red;

    }

  }

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        leading: Icon(
          Icons.coronavirus,
          color: color(),
        ),

        title: const Text("Disease Risk"),

        subtitle: Text(risk),

      ),

    );

  }

}