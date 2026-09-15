import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {

  final String recommendation;

  const RecommendationCard({
    super.key,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Row(

              children: [

                Icon(
                  Icons.lightbulb,
                  color: Colors.amber,
                ),

                SizedBox(width: 10),

                Text(
                  "Recommendation",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 18),

            Text(
              recommendation,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

          ],
        ),
      ),
    );
  }
}