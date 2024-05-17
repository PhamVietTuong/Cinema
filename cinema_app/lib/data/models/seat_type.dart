// ignore_for_file: avoid_print

import 'dart:convert';

import '../../constants.dart';
import 'package:http/http.dart' as http;

class SeatType {
  int id;
  String name;
  int status;

  SeatType({this.id = 0, this.name = "", this.status = 0});

  SeatType.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        name = json["name"] ?? "",
        status = json["status"] ?? 0;

  static Future<List<SeatType>> fetchSeatTypes() async {
    String api = '$serverUrl/seat/seat_type';
    print("API fetch SeatTypes: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch SeatTypes');
    }

    final List<dynamic> seatTypesJsonList = jsonDecode(response.body);
    return seatTypesJsonList.map((json) => SeatType.fromJson(json)).toList();
  }
}
