import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YellowStatusContainer extends StatelessWidget {
  final String trainNo;

  final Map<String, dynamic> trainData;

  final String delay;

  const YellowStatusContainer(
      {super.key,
      required this.trainNo,
      required this.trainData,
      required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.yellow.shade700,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(
            "Train No: $trainNo\n"
            "Station: ${toBeginningOfSentenceCase(trainData["station"])}\n"
            "${toBeginningOfSentenceCase(trainData["status"])} at "
            "${trainData["statusTime"]["hours"]} hours, ${trainData["statusTime"]["minutes"]} minutes\n"
            "$delay",
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
