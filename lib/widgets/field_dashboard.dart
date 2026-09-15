import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {

  final String weather;
  final String time;

  const DashboardHeader({
    super.key,
    required this.weather,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(22),

        gradient: const LinearGradient(

          colors: [

            Color(0xff2E7D32),
            Color(0xff66BB6A),

          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

        ),

      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "AdvanceAgro 2.0",

            style: TextStyle(

              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,

            ),

          ),

          const SizedBox(height: 5),

          const Text(

            "Simulated IoT Smart Agriculture",

            style: TextStyle(

              color: Colors.white70,

            ),

          ),

          const SizedBox(height: 25),

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Weather",

                    style: TextStyle(color: Colors.white70),

                  ),

                  Text(

                    weather,

                    style: const TextStyle(

                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ],

              ),

              Column(

                crossAxisAlignment: CrossAxisAlignment.end,

                children: [

                  const Icon(

                    Icons.cloud,

                    color: Colors.white,

                    size: 45,

                  ),

                  const SizedBox(height: 10),

                  Text(

                    time,

                    style: const TextStyle(

                      color: Colors.white,

                    ),

                  ),

                ],

              )

            ],

          )

        ],

      ),

    );

  }

}