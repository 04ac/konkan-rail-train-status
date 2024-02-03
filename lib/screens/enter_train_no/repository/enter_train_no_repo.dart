import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:konkan_rail_timetable/utils/constants.dart';

class EnterTrainNoRepo {
  static Future<Map<String, dynamic>> getSingleTrainData(String trainNo) async {
    try {
      final res = await http.get(
        Uri.parse(
          '${Constants.FETCH_SINGLE_TRAIN_API}/$trainNo',
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
