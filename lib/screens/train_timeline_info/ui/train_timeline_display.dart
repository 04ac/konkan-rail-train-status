import 'package:flutter/material.dart';

import 'package:konkan_rail_timetable/widgets/stations_list_widget.dart';
import 'package:konkan_rail_timetable/widgets/yellow_status_container.dart';

class TrainTimelineDisplay extends StatelessWidget {
  final bool isDown;

  final String trainNo;

  final Map<String, dynamic> trainData;

  final bool isLeft;

  final String currentStation;

  final String delay;

  final Future<Map<String, dynamic>> allStations;

  const TrainTimelineDisplay({
    super.key,
    required this.isDown,
    required this.trainNo,
    required this.trainData,
    required this.isLeft,
    required this.currentStation,
    required this.delay,
    required this.allStations,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          YellowStatusContainer(
            trainNo: trainNo,
            trainData: trainData,
            delay: delay,
          ),
          FutureBuilder(
            future: allStations,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Expanded(
                    child: Center(
                      child: Text("An unexpected error occurred"),
                    ),
                  );
                }
                final allStations = snapshot.data ?? {};
                final List allStationsList = allStations["stations"]
                    .map((station) => station["name"])
                    .toList();
                final List allStationsDescriptionsList = allStations["stations"]
                    .map((station) => station["description"])
                    .toList();

                final currStatIdx = allStationsList
                    .map((e) => e.toString().toLowerCase())
                    .toList()
                    .indexOf(currentStation);
                return StationsListWidget(
                  allStationsList: allStationsList,
                  allStations: allStations,
                  currStatIdx: currStatIdx,
                  isDown: isDown,
                  isLeft: isLeft,
                  allStationsDescriptionsList: allStationsDescriptionsList,
                );
              } else {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
