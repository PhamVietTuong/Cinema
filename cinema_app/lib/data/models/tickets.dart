// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cinema_app/data/models/ticket_type.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class Ticket {
  int id;
  int seatId;
  int showTimeId;
  int userId;
  DateTime creationTime = DateTime.now();
  int status;

  Ticket({
    this.id = 0,
    this.seatId = 0,
    this.showTimeId = 0,
    this.userId = 0,
    this.status = 0,
  });

  Ticket.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        seatId = json["seat_id"] ?? 0,
        showTimeId = json["showtime_id"] ?? 0,
        userId = json["user_id"] ?? 0,
        creationTime = json["creation_time"] ?? DateTime.now(),
        status = json["status"] ?? 0;
}

abstract class TicketRepository {
  Future<List<Ticket>> fetchTickets();
  Future<List<TicketType>> fetchTicketTypes();

}

class TicketRepositoryIml implements TicketRepository {
  @override
  Future<List<Ticket>> fetchTickets() async {
    String api = '$serverUrl/ticket';
    print("API fetch Tickets: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Tickets');
    }

    final List<dynamic> ticketJsonList = jsonDecode(response.body);
    return ticketJsonList.map((json) => Ticket.fromJson(json)).toList();
  }
  
  @override
  Future<List<TicketType>> fetchTicketTypes() async {
    String api = '$serverUrl/ticket/ticket_type';
    print("API fetch TicketTypes: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch TicketTypes');
    }

    final List<dynamic> ticketTypeJsonList = jsonDecode(response.body);
    return ticketTypeJsonList.map((json) => TicketType.fromJson(json)).toList();
  }
}
