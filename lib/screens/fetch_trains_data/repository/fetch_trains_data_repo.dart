import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';

class FetchTrainsDataRepo {
  static Future<Map<String, dynamic>> getCurrentTrains() async {
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

  static Future<Map<String, dynamic>> getStations() async {
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
}
