import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konkan_rail_timetable/screens/train_timeline_info_screen.dart';

import '../../utils/constants.dart';
import 'bloc/enter_train_no_bloc.dart';

class EnterTrainNoScreen extends StatefulWidget {
  const EnterTrainNoScreen({super.key});

  @override
  State<EnterTrainNoScreen> createState() => _EnterTrainNoScreenState();
}

class _EnterTrainNoScreenState extends State<EnterTrainNoScreen> {
  final _trainNoTec = TextEditingController();
  final _bloc = EnterTrainNoBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konkan Rail Trains"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Single Train Fetch (Uses less data)"),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: _trainNoTec,
              decoration: const InputDecoration(hintText: "Enter Train No."),
            ),
            BlocProvider(
              create: (context) => _bloc,
              child: BlocListener<EnterTrainNoBloc, EnterTrainNoState>(
                listener: (context, state) {
                  switch (state.runtimeType) {
                    case EnterTrainNoSuccessState:
                      final successState = state as EnterTrainNoSuccessState;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            Map<String, dynamic> mp = {};
                            mp.putIfAbsent("trains", () => successState.data);
                            return TrainTimelineInfoScreen(
                              trainNo: successState.trainNo,
                              data: mp,
                              allStations: Future.delayed(
                                Duration.zero,
                                () => successState.stations,
                              ),
                            );
                          },
                        ),
                      );
                    case EnterTrainNoErrorState:
                      const snackBar = SnackBar(
                        content: Text(
                            "Error: Train number not found. It might not have started yet."),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    default:
                  }
                },
                child: ElevatedButton.icon(
                  onPressed: () {
                    _bloc.add(
                        SearchBtnClickedActionEvent(trainNo: _trainNoTec.text));
                  },
                  icon: const Icon(Icons.search),
                  label: const Text("Search"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
