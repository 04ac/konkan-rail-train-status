import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class TrainsListItem extends StatelessWidget {
  const TrainsListItem(
      {super.key,
      required this.trainNo,
      required this.data,
      required this.idx});

  final String trainNo;
  final Map<String, dynamic> data;
  final int idx;

  @override
  Widget build(BuildContext context) {
    final trainData = data["trains"][trainNo];

    final String delay;

    String delayHours = trainData["delayedTime"]["hours"].trim();
    String delayMinutes = trainData["delayedTime"]["minutes"].trim();

    if (int.parse(delayHours == "" ? "0" : delayHours) <= 0) {
      if (int.parse(delayMinutes == "" ? "0" : delayMinutes) <= 0) {
        delay = "On time";
      } else {
        delay = "Delay: $delayMinutes minutes";
      }
    } else {
      delay = "Delay: $delayHours hours, $delayMinutes minutes";
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("${trainData["name"]} - $trainNo"),
          subtitle: Text(
              "Status: ${toBeginningOfSentenceCase(trainData["status"])}\n"
              "Last Station: ${toBeginningOfSentenceCase(trainData["station"])}\n"
              "${toBeginningOfSentenceCase(trainData["status"])} at "
              "${trainData["statusTime"]["hours"]} hours, ${trainData["statusTime"]["minutes"]} minutes\n"
              "$delay\n"
              "Train type: ${trainData["type"]}\n"
              "Direction: ${toBeginningOfSentenceCase(trainData["direction"])}"),
          tileColor: idx % 2 == 0
              ? Colors.yellow.shade200
              : Colors.lightGreen.shade200,
        ),
      ),
    );
  }
}
