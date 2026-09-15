import 'package:flutter/material.dart';
class AIScoreCard extends StatelessWidget {

  final double score;

  const AIScoreCard({
    super.key,
    required this.score,
  });

  Color getColor() {

    if (score >= 85) {
      return Colors.green;
    }

    if (score >= 65) {
      return Colors.orange;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(

              "AI Crop Health Score",

              style: TextStyle(

                fontWeight: FontWeight.bold,

                fontSize: 18,

              ),

            ),

            const SizedBox(height: 18),

            ClipRRect(

              borderRadius: BorderRadius.circular(10),

              child: LinearProgressIndicator(

                value: score / 100,

                minHeight: 14,

                color: getColor(),

                backgroundColor: Colors.grey.shade300,

              ),

            ),

            const SizedBox(height: 12),

            Text(

              "${score.toStringAsFixed(1)}%",

              style: const TextStyle(

                fontSize: 26,

                fontWeight: FontWeight.bold,

              ),

            )

          ],

        ),

      ),

    );
  }
}