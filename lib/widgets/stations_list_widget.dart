import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konkan_rail_timetable/widgets/train_timeline_tile.dart';

class StationsListWidget extends StatelessWidget {
  final List allStationsList;

  final Map<String, dynamic> allStations;

  final int currStatIdx;

  final bool isDown;

  final List allStationsDescriptionsList;

  final bool isLeft;

  const StationsListWidget(
      {super.key,
      required this.allStationsList,
      required this.allStations,
      required this.currStatIdx,
      required this.isDown,
      required this.allStationsDescriptionsList,
      required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemCount: allStations["count"],
          itemBuilder: (context, index) {
            bool isPast = index <= 1;
            int currItemIdx =
                isDown ? currStatIdx - 1 + index : currStatIdx + 1 - index;

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
                endChild: Container(
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  decoration: BoxDecoration(
                    color: index <= 1 ? Colors.green : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      final descriptionText =
                          allStationsDescriptionsList[currItemIdx];

                      SnackBar snackBar;

                      if (descriptionText != "" && descriptionText != "--") {
                        snackBar = SnackBar(
                          content: Text(descriptionText),
                        );
                      } else {
                        snackBar = const SnackBar(
                          content:
                              Text("No description found for this station"),
                        );
                      }

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        toBeginningOfSentenceCase(
                            allStationsList[currItemIdx])!,
                        style: TextStyle(
                          fontSize: 20,
                          color: index <= 1 ? Colors.white : Colors.black,
                        ),
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
  }
}
