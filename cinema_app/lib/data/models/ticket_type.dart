// ignore_for_file: avoid_print

import 'dart:convert';

import '../../constants.dart';
import 'package:http/http.dart' as http;

class TicketType {
  int id;
  String name;
  int status;

  TicketType({this.id = 0, this.name = "", this.status = 0});
  TicketType.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        name = json["name"] ?? "",
        status = json["status"] ?? 0;

  static Future<List<TicketType>> fetchTicketTypes() async {
    String api = '$serverUrl/ticket/ticket_type';
    print("API fetch TicketTypes: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch TicketTypes');
    }

    final List<dynamic> ticketTypesJsonList = jsonDecode(response.body);
    return ticketTypesJsonList
        .map((json) => TicketType.fromJson(json))
        .toList();
  }
}


