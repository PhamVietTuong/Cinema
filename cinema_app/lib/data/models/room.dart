// ignore_for_file: avoid_print

//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import '../../constants.dart';

class Room {
  String id;
  String name;
  String theaterId;
  int maxRow;
  int maxCol;
  int status;



  Room(
      {this.id = "",
      this.name = "",
      this.theaterId = "",
      this.maxRow = 0,
      this.maxCol = 0,
      this.status = -1});

  Room.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        theaterId = json['theaterId'] ?? "",
        name = json['name'] ?? "",
        maxRow = json['width'] ?? 0,
        maxCol = json['length'] ?? 0,
        status = json['status'] ?? -1;


}


