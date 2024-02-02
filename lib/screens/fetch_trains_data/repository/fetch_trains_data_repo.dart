import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:konkan_rail_timetable/utils/constants.dart';

class FetchTrainsDataRepo {
  static http.Client client = http.Client();
  static Future<Map<String, dynamic>> getCurrentTrains() async {
    try {
      final res = await client.get(
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
      CacheManager.logLevel = CacheManagerLogLevel.verbose;

      final cache = CacheManager(Config("stations.json",
          stalePeriod: const Duration(days: Constants.CACHE_STATIONS_DAYS)));

      final File jsonFile =
          await cache.getSingleFile(Constants.FETCH_STATIONS_API);

      final String jsonData = await jsonFile.readAsString(encoding: utf8);

      return jsonDecode(jsonData);
    } catch (e) {
      throw e.toString();
    }
  }
}
