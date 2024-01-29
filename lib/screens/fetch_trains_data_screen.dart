import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:konkan_rail_timetable/screens/train_timeline_info_screen.dart';
import 'package:konkan_rail_timetable/utils/constants.dart';
import 'package:konkan_rail_timetable/widgets/trains_list_item.dart';

class FetchTrainsDataScreen extends StatefulWidget {
  const FetchTrainsDataScreen({super.key});

  @override
  State<FetchTrainsDataScreen> createState() => _FetchTrainsDataScreenState();
}

class _FetchTrainsDataScreenState extends State<FetchTrainsDataScreen> {
  late Future<Map<String, dynamic>> respo;
  late Future<Map<String, dynamic>> allStations;
  late Map<String, dynamic> data;

  Future<Map<String, dynamic>> getCurrentTrains() async {
    try {
      final res = await http.get(
        Uri.parse(
          Constants.FETCH_TRAINS_API,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );
      final data = await jsonDecode(res.body);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> getStations() async {
    try {
      final res = await http.get(
        Uri.parse(
          Constants.FETCH_STATIONS_API,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );
      final data = await jsonDecode(res.body);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      respo = getCurrentTrains();
      allStations = getStations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("Konkan Rail Trains"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                respo = getCurrentTrains();
                allStations = getStations();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
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
                        child: Text("An unexpected error occurred"),
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
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TrainTimelineInfoScreen(
                              trainNo: trainNo,
                              data: data,
                              allStations: allStations,
                            ),
                          )),
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
