import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class TrainsListItem extends StatelessWidget {
  TrainsListItem(
      {super.key,
      required this.trainNo,
      required this.data,
      required this.idx});

  String trainNo;
  final data;
  int idx;

  @override
  Widget build(BuildContext context) {
    final trainData = data!["trains"][trainNo];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("${trainData["name"]} - $trainNo"),
          subtitle: Text("Status: ${trainData["status"]}\n"
              "Last Station: ${toBeginningOfSentenceCase(trainData["station"])}\n"
              "${toBeginningOfSentenceCase(trainData["status"])} at "
              "${trainData["statusTime"]["hours"]} hours, ${trainData["statusTime"]["minutes"]} minutes\n"
              "Delay: ${trainData["delayedTime"]["hours"]} hours, ${trainData["delayedTime"]["minutes"]} minutes\n"
              "Train type: ${trainData["type"]}\n"
              "Direction: ${trainData["direction"]}"),
          tileColor: idx % 2 == 0
              ? Colors.yellow.shade200
              : Colors.lightGreen.shade200,
        ),
      ),
    );
  }
}
