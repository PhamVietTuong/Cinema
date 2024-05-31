// ignore_for_file: avoid_print

// import 'dart:convert';

// import 'package:cinema_app/data/models/ticket_type.dart';
// import 'package:http/http.dart' as http;

import '../../config.dart';

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


}

class TicketRepositoryIml implements TicketRepository {
  
}
