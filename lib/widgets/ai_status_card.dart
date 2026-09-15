import 'package:flutter/material.dart';

class AIStatusCard extends StatelessWidget {

  final String title;

  final String value;

  final IconData icon;

  final Color color;

  const AIStatusCard({

    super.key,

    required this.title,

    required this.value,

    required this.icon,

    required this.color,

  });

  @override
  Widget build(BuildContext context) {

    return Expanded(

      child: Card(

        elevation: 4,

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(18),

        ),

        child: Padding(

          padding: const EdgeInsets.all(18),

          child: Column(

            children: [

              Icon(

                icon,

                color: color,

                size: 36,

              ),

              const SizedBox(height: 12),

              Text(

                title,

                style: const TextStyle(

                  fontWeight: FontWeight.bold,

                ),

              ),

              const SizedBox(height: 8),

              Text(

                value,

                textAlign: TextAlign.center,

                style: TextStyle(

                  color: color,

                  fontWeight: FontWeight.bold,

                  fontSize: 16,

                ),

              )

            ],

          ),

        ),

      ),

    );

  }

}