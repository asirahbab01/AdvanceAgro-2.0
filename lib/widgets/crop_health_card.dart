import 'package:flutter/material.dart';

class CropHealthCard extends StatelessWidget {

  final double health;

  const CropHealthCard({
    super.key,
    required this.health,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Row(

          children: [

            const Icon(
              Icons.eco,
              color: Colors.green,
              size: 45,
            ),

            const SizedBox(width: 18),

            Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Crop Health Index",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),

                  ),

                  const SizedBox(height: 8),

                  LinearProgressIndicator(

                    value: health/100,

                    minHeight: 10,

                    borderRadius: BorderRadius.circular(20),

                  ),

                  const SizedBox(height: 10),

                  Text("${health.toStringAsFixed(0)} % Healthy"),

                ],

              ),

            )

          ],

        ),

      ),

    );
  }
}