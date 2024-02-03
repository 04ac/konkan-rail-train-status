import 'package:flutter/material.dart';
import 'package:konkan_rail_timetable/screens/enter_train_no/enter_train_no_screen.dart';
import 'package:konkan_rail_timetable/screens/fetch_trains_data/ui/fetch_trains_data_screen.dart';
import 'package:konkan_rail_timetable/screens/fetch_trains_data/repository/fetch_trains_data_repo.dart';
import 'package:http/http.dart' as http;

class HomePageWithNavBar extends StatefulWidget {
  const HomePageWithNavBar({super.key});

  @override
  State<HomePageWithNavBar> createState() => _HomePageWithNavBarState();
}

class _HomePageWithNavBarState extends State<HomePageWithNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FetchTrainsDataScreen(),
    EnterTrainNoScreen(),
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      FetchTrainsDataRepo.client.close();
      FetchTrainsDataRepo.client = http.Client();
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.train_outlined),
                Icon(Icons.train),
                Icon(Icons.train_outlined),
              ],
            ),
            label: 'All Trains',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.train_outlined),
            label: 'Single Train',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
