import 'package:flutter/material.dart';
import 'package:konkan_rail_timetable/screens/train_timeline_info/ui/train_timeline_info_screen.dart';
import 'package:konkan_rail_timetable/screens/fetch_trains_data/repository/fetch_trains_data_repo.dart';
import 'package:konkan_rail_timetable/utils/drawer.dart';
import 'package:konkan_rail_timetable/widgets/trains_list_item.dart';
import 'package:konkan_rail_timetable/utils/constants.dart';

class FetchTrainsDataScreen extends StatefulWidget {
  const FetchTrainsDataScreen({super.key});

  @override
  State<FetchTrainsDataScreen> createState() => _FetchTrainsDataScreenState();
}

class _FetchTrainsDataScreenState extends State<FetchTrainsDataScreen> {
  late Future<Map<String, dynamic>> respo;
  late Future<Map<String, dynamic>> allStations;
  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    setState(() {
      respo = FetchTrainsDataRepo.getCurrentTrains();
      allStations = FetchTrainsDataRepo.getStations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            respo = FetchTrainsDataRepo.getCurrentTrains();
            allStations = FetchTrainsDataRepo.getStations();
          });
        },
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: const Text(Constants.APPBAR_TITLE_TEXT),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    CustomSearchDelegate(data: data, allStations: allStations),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: respo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                            "An unexpected error occurred, please try again after a while."),
                      ),
                    );
                  }
                  data = snapshot.data ?? {};
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data["count"],
                      itemBuilder: (context, index) {
                        String trainNo =
                            (data["trains"] as Map<String, dynamic>)
                                .keys
                                .toList()[index];
                        return GestureDetector(
                          child: TrainsListItem(
                            trainNo: trainNo,
                            data: data,
                            idx: index,
                          ),
                          onTap: () => Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) => TrainTimelineInfoScreen(
                                    trainNo: trainNo,
                                    data: data,
                                    allStations: allStations,
                                  ),
                                ),
                              )
                              .whenComplete(() => ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar()),
                        );
                      },
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

class CustomSearchDelegate extends SearchDelegate {
  late Map<String, dynamic> data;
  late Future<Map<String, dynamic>> allStations;
  List<String> searchTerms = [];

  CustomSearchDelegate({required this.data, required this.allStations}) {
    searchTerms = data["trains"].keys.toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var train in searchTerms) {
      if (data["trains"][train]["name"]
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          train.contains(query)) {
        matchQuery.add(train);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String trainNo = matchQuery[index];
        return GestureDetector(
          child: TrainsListItem(
            trainNo: trainNo,
            data: data,
            idx: index,
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TrainTimelineInfoScreen(
              trainNo: trainNo,
              data: data,
              allStations: allStations,
            ),
          )),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var train in searchTerms) {
      if (data["trains"][train]["name"]
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          train.contains(query)) {
        matchQuery.add(train);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String trainNo = matchQuery[index];
        return GestureDetector(
          child: TrainsListItem(
            trainNo: trainNo,
            data: data,
            idx: index,
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TrainTimelineInfoScreen(
              trainNo: trainNo,
              data: data,
              allStations: allStations,
            ),
          )),
        );
      },
    );
  }
}
