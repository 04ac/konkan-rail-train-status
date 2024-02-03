import 'package:flutter/material.dart';
import 'package:konkan_rail_timetable/utils/colors.dart';
import 'package:konkan_rail_timetable/utils/constants.dart';

import 'package:konkan_rail_timetable/screens/credits_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.yellowDrawerHeader,
            ),
            child: Column(
              children: [
                const Text(
                  Constants.APPBAR_TITLE_TEXT,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.train_outlined,
                  size: 50,
                  color: Colors.grey.shade50,
                ),
              ],
            ),
          ),
          ListTile(
            trailing: const Icon(
              Icons.home_outlined,
              color: Colors.grey,
            ),
            title: const Text('Home'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: const Icon(
              Icons.favorite_outline_outlined,
              color: Colors.grey,
            ),
            title: const Text('Credits'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreditsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
