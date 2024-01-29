import 'package:flutter/material.dart';
import 'package:konkan_rail_timetable/screens/enter_train_no/enter_train_no_screen.dart';
import 'package:konkan_rail_timetable/screens/fetch_trains_data_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konkan Rail Trains"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.lightGreen,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FetchTrainsDataScreen()));
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
                ),
                child: const Text("All Trains"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnterTrainNoScreen()));
                  },
                  child: const Text("Single Train Search\n(Uses less data)")),
            ],
          ),
        ),
      ),
    );
  }
}
