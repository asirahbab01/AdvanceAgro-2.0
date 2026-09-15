import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {

  final String title;

  final String value;

  final IconData icon;

  final Color color;

  const SensorCard({

    super.key,

    required this.title,

    required this.value,

    required this.icon,

    required this.color,

  });

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(

      duration: const Duration(milliseconds: 500),

      child: Card(

        elevation: 3,

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(18),

        ),

        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(

                icon,

                size: 40,

                color: color,

              ),

              const SizedBox(height: 12),

              Text(

                title,

                textAlign: TextAlign.center,

                style: const TextStyle(

                  fontWeight: FontWeight.bold,

                ),

              ),

              const SizedBox(height: 10),

              Text(

                value,

                style: const TextStyle(

                  fontSize: 18,

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}