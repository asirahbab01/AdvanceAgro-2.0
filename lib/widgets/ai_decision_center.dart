import 'package:flutter/material.dart';

import 'ai_score_card.dart';
import 'ai_status_card.dart';

class AIDecisionCenter extends StatelessWidget {

  final double healthScore;

  final String disease;

  final String irrigation;

  final String stress;

  const AIDecisionCenter({

    super.key,

    required this.healthScore,

    required this.disease,

    required this.irrigation,

    required this.stress,

  });

  Color diseaseColor(){

    switch(disease){

      case "Low":
        return Colors.green;

      case "Moderate":
        return Colors.orange;

      default:
        return Colors.red;

    }

  }

  Color irrigationColor(){

    if(irrigation=="Not Required"){

      return Colors.green;

    }

    if(irrigation=="Moderate"){

      return Colors.orange;

    }

    return Colors.red;

  }

  Color stressColor(){

    if(stress=="Normal"){

      return Colors.green;

    }

    if(stress=="Water Stress"){

      return Colors.orange;

    }

    return Colors.red;

  }

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        AIScoreCard(
          score: healthScore,
        ),

        const SizedBox(height: 15),

        Row(

          children: [

            AIStatusCard(

              title: "Disease",

              value: disease,

              icon: Icons.coronavirus,

              color: diseaseColor(),

            ),

            const SizedBox(width: 10),

            AIStatusCard(

              title: "Water",

              value: irrigation,

              icon: Icons.water_drop,

              color: irrigationColor(),

            ),

          ],

        ),

        const SizedBox(height: 10),

        Row(

          children: [

            AIStatusCard(

              title: "Stress",

              value: stress,

              icon: Icons.local_fire_department,

              color: stressColor(),

            ),

            const SizedBox(width: 10),

            const AIStatusCard(

              title: "AI",

              value: "92%",

              icon: Icons.auto_awesome,

              color: Colors.blue,

            ),

          ],

        )

      ],

    );

  }

}