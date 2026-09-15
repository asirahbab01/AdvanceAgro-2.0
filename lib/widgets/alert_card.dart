import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {

  final String alert;

  const AlertCard({
    super.key,
    required this.alert,
  });

  Color cardColor() {

    if (alert.toLowerCase().contains("critical")) {
      return Colors.red;
    }

    if (alert.toLowerCase().contains("warning")) {
      return Colors.orange;
    }

    return Colors.green;
  }

  IconData icon() {

    if (alert.toLowerCase().contains("critical")) {
      return Icons.error;
    }

    if (alert.toLowerCase().contains("warning")) {
      return Icons.warning;
    }

    return Icons.check_circle;
  }

  @override
  Widget build(BuildContext context) {

    return Card(

      color: cardColor().withOpacity(.12),

      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Row(

          children: [

            Icon(
              icon(),
              color: cardColor(),
              size: 35,
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                alert,
                style: TextStyle(
                  color: cardColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}