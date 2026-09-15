import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CropInfoCard extends StatelessWidget {

  final DateTime plantedDate;

  final VoidCallback onSelectDate;

  const CropInfoCard({

    super.key,

    required this.plantedDate,

    required this.onSelectDate,

  });

  @override
  Widget build(BuildContext context) {

    final cropAge =
        DateTime.now().difference(plantedDate).inDays;

    final harvestDate =
        plantedDate.add(const Duration(days: 120));

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20),

      ),

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Row(

              children: [

                Icon(
                  Icons.grass,
                  color: Colors.green,
                ),

                SizedBox(width: 10),

                Text(

                  "Crop Information",

                  style: TextStyle(

                    fontWeight: FontWeight.bold,

                    fontSize: 20,

                  ),

                )

              ],

            ),

            const SizedBox(height: 18),

            Row(

              children: [

                const Icon(Icons.calendar_today),

                const SizedBox(width: 10),

                Text(

                  "Planted On",

                  style: TextStyle(

                    color: Colors.grey.shade700,

                  ),

                ),

              ],

            ),

            const SizedBox(height: 8),

            Text(

              DateFormat('dd MMM yyyy').format(plantedDate),

              style: const TextStyle(

                fontSize: 18,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 18),

            Text(

              "Crop Age : $cropAge Days",

              style: const TextStyle(

                fontSize: 17,

              ),

            ),

            const SizedBox(height: 10),

            Text(

              "Estimated Harvest",

              style: TextStyle(

                color: Colors.grey.shade700,

              ),

            ),

            const SizedBox(height: 5),

            Text(

              DateFormat('dd MMM yyyy')
                  .format(harvestDate),

              style: const TextStyle(

                fontWeight: FontWeight.bold,

                fontSize: 17,

              ),

            ),

            const SizedBox(height: 22),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: onSelectDate,

                icon: const Icon(Icons.edit_calendar),

                label: const Text("Change Planting Date"),

              ),

            )

          ],

        ),

      ),

    );

  }

}