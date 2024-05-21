// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class Seat {
  int id;
  int seatTypeId;
  int roomId;
  int rowIndex;
  int colIndex;
  int isSeat;
  int status; //0= đá bán, 1 còn trống, 2 đang chọn, 3 đang chờ

  Seat(
      {this.id = 0,
      this.colIndex = 0,
      this.roomId = 0,
      this.rowIndex = 0,
      this.seatTypeId = 0,
      this.isSeat = 0,
      this.status = 1});

  Seat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        colIndex = json['col_index'] ?? 0,
        roomId = json['room_id'] ?? 0,
        rowIndex = json['row_index'] ?? 0,
        seatTypeId = json['seat_type_id'] ?? 0,
        status = json['status'] ?? 1,
        isSeat = json['is_seat'] ?? 0;
}

abstract class SeatRepository {
  Future<List<Seat>> fetchSeatsByRoomId(int roomId);
  Future<List<Seat>> fetchSeatsInTicketsByShowtimeId(int showtimeId);
}

class SeatRepositoryIml implements SeatRepository {
  @override
  Future<List<Seat>> fetchSeatsByRoomId(int roomId) async {
    String api = '$serverUrl/seat/room_id$roomId';
    print("API fetch Seats by room id: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Seats by room id');
    }

    final List<dynamic> seatJsonList = jsonDecode(response.body);
    return seatJsonList.map((json) => Seat.fromJson(json)).toList();
  }

  @override
  Future<List<Seat>> fetchSeatsInTicketsByShowtimeId(int showtimeId) async {
    String api = '$serverUrl/seat/ticket$showtimeId';
    print("API fetch Seats in ticket by showtime Id: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Seats in ticket by showtime Id');
    }

    final List<dynamic> seatJsonList = jsonDecode(response.body);
    return seatJsonList.map((json) => Seat.fromJson({"id": json["seat_id"]})).toList();
  }
}
