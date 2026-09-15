import 'package:flutter/material.dart';

class IrrigationCard extends StatelessWidget {

  final String recommendation;

  const IrrigationCard({
    super.key,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        leading: const Icon(
          Icons.water_drop,
          color: Colors.blue,
        ),

        title: const Text("Irrigation"),

        subtitle: Text(recommendation),

      ),

    );

  }

}