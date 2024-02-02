import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class TrainsListItem extends StatelessWidget {
  TrainsListItem(
      {super.key,
      required this.trainNo,
      required this.data,
      required this.idx});

  final String trainNo;
  final data;
  final int idx;

  @override
  Widget build(BuildContext context) {
    final trainData = data!["trains"][trainNo];

    final String delay;

    if (trainData["delayedTime"]["hours"] == "0" ||
        trainData["delayedTime"]["hours"] == "00") {
      if (trainData["delayedTime"]["minutes"] == "0" ||
          trainData["delayedTime"]["minutes"] == "00") {
        delay = "On time";
      } else {
        delay = "Delay: ${trainData["delayedTime"]["minutes"]} minutes";
      }
    } else {
      delay =
          "Delay: ${trainData["delayedTime"]["hours"]} hours, ${trainData["delayedTime"]["minutes"]} minutes";
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
              "${delay}\n"
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
