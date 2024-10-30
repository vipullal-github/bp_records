import 'package:bp_records/models/bp_record.dart';
import 'package:flutter/material.dart';

class BpWidget extends StatelessWidget {
  final BpRecord rec;
  const BpWidget({super.key, required this.rec});

  String _formatDate(DateTime dt) {
    return "${dt.day}/${dt.month}/${dt.year}";
  }

  @override
  Widget build(BuildContext context) {
    //TextStyle tsBold = Theme.of(context).textTheme.displaySmall!.copyWith();
    const TextStyle tsBold = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
      child: Container(
        color: Colors.grey.shade100,
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Date",
                  style: tsBold,
                ),
                const SizedBox(width: 10),
                Text(_formatDate(rec.dateTaken)),
              ],
            ),
            Row(
              children: [
                // systolic
                const Text(
                  "Sytstoloc",
                  style: tsBold,
                ),
                const SizedBox(width: 10),
                Text(rec.systolic.toString()),
                // Diastolic
                const SizedBox(width: 20),
                const Text("Diastolic", style: tsBold),
                const SizedBox(width: 10),
                Text(rec.diastolic.toString()),
                // Pulse
                const SizedBox(width: 20),

                const Text("Pulse", style: tsBold),
                const SizedBox(width: 10),
                Text(rec.pulse.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
