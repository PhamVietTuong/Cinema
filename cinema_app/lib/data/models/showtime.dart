// ignore_for_file: avoid_print

//import 'dart:convert';

import 'package:cinema_app/data/models/room.dart';
import 'package:cinema_app/data/models/showtime_type.dart';

//import '../../constants.dart';
//import 'package:http/http.dart' as http;

class Showtime {
  String id;
  String movieId;
  bool status;

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  int projectionForm;
  Room room = Room();

  Showtime({this.id = "", this.movieId = "", this.status = false,this.projectionForm=0});

  Showtime.fromJson(Map<String, dynamic> json)
      : id = json['id']??"",
        movieId = json['movieId'] ?? "",
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        room = Room(id: json["room_id"] ?? 0),
        projectionForm=json["projectionForm"]??0,
        status = json['status'] ?? 0;

  String getFormatTime() {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }

  String getFormatDate() {
    return '${startTime.day.toString().padLeft(2, '0')}/${startTime.month.toString().padLeft(2, '0')}';
  }
}

abstract class ShowtimeRepository {
  // Future<List<Showtime>> fetchShowtimes();
  // Future<List<Showtime>> fetchShowtimesByDate(String date, String theaterId);
}

class ShowtimeRepositoryIml implements ShowtimeRepository {
 // @override
  //Future<List<Showtime>> fetchShowtimes() async {
  //   String api = '$serverUrl/showtime';
  //   print("API fetch Showtimes: $api");

  //   final response = await http.get(Uri.parse(api));

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to fetch Showtimes');
  //   }

  //   final List<dynamic> showtimeJsonList = jsonDecode(response.body);
  //   return showtimeJsonList.map((json) => Showtime.fromJson(json)).toList();
  // }

  // @override
  // Future<List<Showtime>> fetchShowtimesByDate(String date, String theaterId) async {
  //   String api = '$serverUrl/showtime/theater$theaterId/date$date';
  //   print("API fetch Showtimes by date: $api");

  //   final response = await http.get(Uri.parse(api));

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to fetch Showtimes');
  //   }

  //   final List<dynamic> showtimeJsonList = jsonDecode(response.body);
  //   return showtimeJsonList.map((json) => Showtime.fromJson(json)).toList();
  // }
}
