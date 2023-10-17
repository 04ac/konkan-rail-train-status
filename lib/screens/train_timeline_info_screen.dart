import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:konkan_rail_timetable/widgets/train_timeline_tile.dart';

class TrainTimelineInfoScreen extends StatefulWidget {
  final data;
  final String trainNo;
  final Future<Map<String, dynamic>> allStations;

  const TrainTimelineInfoScreen({
    super.key,
    required this.trainNo,
    required this.data,
    required this.allStations,
  });

  @override
  State<TrainTimelineInfoScreen> createState() =>
      _TrainTimelineInfoScreenState();
}

class _TrainTimelineInfoScreenState extends State<TrainTimelineInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final String currentStaion =
        widget.data["trains"][widget.trainNo]["station"];
    final String currStatus = widget.data["trains"][widget.trainNo]["status"];
    final String direction = widget.data["trains"][widget.trainNo]["direction"];
    final bool isDown = direction == 'down';
    final bool isLeft = currStatus == 'left';
    final trainData = widget.data!["trains"][widget.trainNo];
    return Scaffold(
      appBar: AppBar(
        title: Text(trainData["name"]),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.yellow.shade700,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    "Train No: ${widget.trainNo}\n"
                    "Station: ${toBeginningOfSentenceCase(trainData["station"])}\n"
                    "${toBeginningOfSentenceCase(trainData["status"])} at "
                    "${trainData["statusTime"]["hours"]} hours, ${trainData["statusTime"]["minutes"]} minutes\n"
                    "Delay: ${trainData["delayedTime"]["hours"]} hours, ${trainData["delayedTime"]["minutes"]} minutes",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: widget.allStations,
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
                  List<String> allStationsList =
                      allStations["stations"].keys.toList();
                  final currStatIdx = allStationsList.indexOf(currentStaion);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          bool isPast = index <= 1;
                          int currItemIdx = isDown
                              ? currStatIdx - 1 + index
                              : currStatIdx + 1 - index;

                          //To deal with edge cases of
                          //first and last stations of Konkan Railway,
                          //namely Roha and Thokur (as per current API, Oct 2023)
                          if (currItemIdx < 0) {
                            return const SizedBox(height: 0);
                          }
                          if (currItemIdx >= allStationsList.length) {
                            return const SizedBox(height: 0);
                          }

                          return SizedBox(
                            height: 150,
                            child: TrainTimelineTile(
                              isFirst: false,
                              isLast: false,
                              isPast: isPast,
                              isLeft: isLeft,
                              idx: index,
                              endchild: Container(
                                height: 60,
                                margin:
                                    const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                decoration: BoxDecoration(
                                  color: index <= 1
                                      ? Colors.green
                                      : Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        allStationsList[currItemIdx])!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: index <= 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
      ),
    );
  }
}
