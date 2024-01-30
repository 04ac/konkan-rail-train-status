import 'package:flutter/material.dart';
import 'package:konkan_rail_timetable/screens/enter_train_no/enter_train_no_screen.dart';
import 'package:konkan_rail_timetable/screens/fetch_trains_data/fetch_trains_data_screen.dart';

class HomePageWIthNavBar extends StatefulWidget {
  const HomePageWIthNavBar({super.key});

  @override
  State<HomePageWIthNavBar> createState() => _HomePageWIthNavBarState();
}

class _HomePageWIthNavBarState extends State<HomePageWIthNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    EnterTrainNoScreen(),
    FetchTrainsDataScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            icon: Icon(Icons.train_outlined),
            label: 'Single Train Fetch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.train_sharp),
            label: 'All Trains',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
