// ignore_for_file: avoid_print

import 'dart:convert';

import '../../config.dart';
import 'package:http/http.dart' as http;

class TicketOption {
  String ticketTypeId;
  String ticketTypeName;
  String seatTypeId;
  String seatTypeName;
  int price;
  int quantity;

  TicketOption(
      {this.price = 0,
      this.quantity = 0,
      this.seatTypeId = "",
      this.seatTypeName = "",
      this.ticketTypeId = "",
      this.ticketTypeName = ""});
  TicketOption.fromJson(Map<String, dynamic> json)
      : ticketTypeId = json["ticketTypeId"] ?? "",
        ticketTypeName = json["ticketTypeName"] ?? "",
        seatTypeId = json["seatTypeId"] ?? "",
        seatTypeName = json["seatTypeName"] ?? "",
        price = json["price"] ?? 0,
        quantity = 0;

  String getName() {
    return '$seatTypeName $ticketTypeName';
  }
}

abstract class TicketRepository {
  Future<List<TicketOption>> fetchTicketByRoomAndShowtimeId(
      String showtimeId, String roomId);
}

class TicketRepositoryIml implements TicketRepository {
  @override
  Future<List<TicketOption>> fetchTicketByRoomAndShowtimeId(
      String showtimeId, String roomId) async {
    String api = '$serverUrl/api/Cinemas/TicketTypeByShowTimeAndRoomId';
    print("API fetch theates: $api");

    final response = await http.post(Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"showTimeId": showtimeId, "roomId": roomId}));

    if (response.statusCode == 204) return [];
    if (response.statusCode == 200) {
      final List<dynamic> theaterJsonList = jsonDecode(response.body);
      return theaterJsonList
          .map((json) => TicketOption.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch theaters');
    }
  }
}
