// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cinema_app/data/models/seat_row.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class Seat {
  String seatTypeId;
  String seatTypeName;

  //String roomId;
  String name;
  int colIndex;
  bool isSeat;
  int status; //0= đá bán, 1 còn trống, 2 đang chọn, 3 đang chờ

  Seat(
      {this.colIndex = 0,
      // this.roomId = "",
      this.name = "",
      this.seatTypeId = "",
      this.seatTypeName = "",
      this.isSeat = false,
      this.status = 1});

  Seat.fromJson(Map<String, dynamic> json)
      : colIndex = json['colIndex'] ?? 0,
        //  roomId = json['roomId'] ?? "",
        name = json["name"] ?? "",
        seatTypeId = json['seatTypeId'] ?? "",
        seatTypeName = json['seatTypeName'] ?? "",
        status = json['seatStatus'] ?? 1,
        isSeat = json['isSeat'] ?? false;

  String getRowName() {
    return name.isNotEmpty ? name.split('').first : '';
  }
}

abstract class SeatRepository {
  Future<List<SeatRowData>> fetchSeatsByShowtimeIdAndRoomId(
      String roomId, String showtimeId);
}

class SeatRepositoryIml implements SeatRepository {
  @override
  Future<List<SeatRowData>> fetchSeatsByShowtimeIdAndRoomId(
      String roomId, String showtimeId) async {
    String api = '$serverUrl/api/Cinemas/SeatByShowTimeAndRoomId';
    print("API fetch Seats by room id: $api");

    final response = await http.post(Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"showTimeId": showtimeId, "roomId": roomId}));

    if (response.statusCode == 204) return [];
    if (response.statusCode == 200) {
      final dynamic seatJson = jsonDecode(response.body);
      return (seatJson["rowName"] as List)
          .map((json) => SeatRowData.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch Seats by showtimeid and room id, status code: ${response.statusCode}');
    }

    // print(seatJson["rowName"]);
  }
}
