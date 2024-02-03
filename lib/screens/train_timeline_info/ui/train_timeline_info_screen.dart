import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konkan_rail_timetable/screens/train_timeline_info/ui/train_timeline_display.dart';
import 'package:konkan_rail_timetable/screens/train_timeline_info/bloc/train_timeline_info_bloc.dart';

class TrainTimelineInfoScreen extends StatefulWidget {
  final Map<String, dynamic> data;
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
  final TrainTimelineInfoBloc _bloc = TrainTimelineInfoBloc();

  late String currentStation;
  late String currStatus;
  late String direction;
  late bool isDown;
  late bool isLeft;
  late Map<String, dynamic> trainData;
  late String delay;
  @override
  Widget build(BuildContext context) {
    initializeVars(widget.data);

    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(trainData["name"]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _bloc.add(TrainTimelineRefreshBtnClickedEvent(
              trainNo: widget.trainNo,
            ));
          },
          child: const Icon(Icons.refresh),
        ),
        body: BlocBuilder<TrainTimelineInfoBloc, TrainTimelineInfoState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case TrainTimelineInfoLoading:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case TrainTimelineInfoFailure:
                return const Center(
                  child: Text(
                    "Oops! An error occurred",
                  ),
                );
              case TrainTimelineInfoSuccess:
                initializeVars((state as TrainTimelineInfoSuccess).data);
                return TrainTimelineDisplay(
                  isDown: isDown,
                  trainNo: widget.trainNo,
                  trainData: trainData,
                  isLeft: isLeft,
                  currentStation: currentStation,
                  delay: delay,
                  allStations: widget.allStations,
                );
              default:
                return TrainTimelineDisplay(
                  isDown: isDown,
                  trainNo: widget.trainNo,
                  trainData: trainData,
                  isLeft: isLeft,
                  currentStation: currentStation,
                  delay: delay,
                  allStations: widget.allStations,
                );
            }
          },
        ),
      ),
    );
  }

  void initializeVars(Map<String, dynamic> data) {
    currentStation = data["trains"][widget.trainNo]["station"];
    currStatus = data["trains"][widget.trainNo]["status"];
    direction = data["trains"][widget.trainNo]["direction"];
    isDown = direction == 'down';
    isLeft = currStatus == 'left';
    trainData = data["trains"][widget.trainNo];

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
  }
}
