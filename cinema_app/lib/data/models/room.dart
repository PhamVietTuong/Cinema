// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cinema_app/data/models/ticket_option.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class Room {
  int id;
  String name;
  int theaterId;
  int maxRow;
 // int maxCol;
  int status;

  List<String> seatTypeIds = List.filled(0, "", growable: true);

  Room(
      {this.id = 0,
      this.name = "",
      this.theaterId = 0,
      this.maxRow = 0,
    //  this.maxCol = 0,
      this.status = 0});

  Room.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        theaterId = json['theater_id'] ?? 0,
        name = json['name'] ?? "",
        maxRow = json['max_row'] ?? 0,
       // maxCol = json['max_col'] ?? 0,
        status = json['status'] ?? 0,
        seatTypeIds = json["seat_type_ids"].split(',');
}

abstract class RoomRepository {
  Future<List<Room>> fetchRooms();
  Future<Room> fetchRoomById(int id);
  Future<List<TicketOption>> fetchTicketOptionsBySeatIds(String seatIds);
}

class RoomRepositoryIml implements RoomRepository {
  @override
  Future<List<Room>> fetchRooms() async {
    String api = '$serverUrl/room';
    print("API fetch theates: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch rooms');
    }

    final List<dynamic> roomJsonList = jsonDecode(response.body);
    return roomJsonList.map((json) => Room.fromJson(json)).toList();
  }

  @override
  Future<Room> fetchRoomById(int id) async {
    String api = '$serverUrl/room/id$id';
    print("API fetch room by id: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch room by id');
    }

    final List<dynamic> roomJsonList = jsonDecode(response.body);
    return Room.fromJson(roomJsonList[0]);
  }

  @override
  Future<List<TicketOption>> fetchTicketOptionsBySeatIds(String seatIds) async {
    String api = '$serverUrl/room/seat_id$seatIds';
    print("API fetch TicketOption by seat_id: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch TicketOption by seat_id');
    }

    final List<dynamic> ticketOptionJsonList = jsonDecode(response.body);
    return ticketOptionJsonList
        .map((json) => TicketOption.fromJson(json))
        .toList();
  }
}
