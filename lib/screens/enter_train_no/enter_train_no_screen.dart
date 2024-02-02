import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konkan_rail_timetable/screens/train_timeline_info_screen.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("Konkan Rail Trains"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Single Train Information Fetcher\n(Best for slow internet)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _trainNoTec,
                decoration:
                    const InputDecoration(hintText: "Enter train number"),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocProvider(
                create: (context) => _bloc,
                child: BlocListener<EnterTrainNoBloc, EnterTrainNoState>(
                  listener: (context, state) {
                    switch (state.runtimeType) {
                      case EnterTrainNoLoadingState:
                        const snackBar = SnackBar(
                          content: Text('Fetching train details...'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        break;
                      case EnterTrainNoSuccessState:
                        final successState = state as EnterTrainNoSuccessState;
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        break;
                      case EnterTrainNoErrorStateRequestFailed:
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        const snackBar = SnackBar(
                          content: Text(
                              "Error: Train not found. It might not have started yet."),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        break;
                      default:
                    }
                  },
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_trainNoTec.text == "") {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        const snackBar = SnackBar(
                          content: Text("Error: Train number is blank"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        _bloc.add(SearchBtnClickedActionEvent(
                            trainNo: _trainNoTec.text));
                      }
                    },
                    icon: const Icon(Icons.search),
                    label: const Text(
                      "Search",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
