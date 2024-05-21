// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cinema_app/data/models/room.dart';
import 'package:cinema_app/data/models/showtime_type.dart';

import '../../constants.dart';
import 'package:http/http.dart' as http;

class Showtime {
  int id;
  int movieId;
  int status;

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  ShowTimeType type = ShowTimeType();
  Room room = Room();

  Showtime({this.id = 0, this.movieId = 0, this.status = 0});

  Showtime.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        movieId = json['movie_id'] ?? 0,
        startTime = DateTime.parse(json['start_time']),
        endTime = DateTime.parse(json['end_time']),
        room = Room(id: json["room_id"] ?? 0),
        type =
            ShowTimeType(id: json["st_id"] ?? 0, name: json["st_name"] ?? ""),
        status = json['status'] ?? 0;

  String getFormatTime() {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }

  String getFormatDate() {
    return '${startTime.day.toString().padLeft(2, '0')}/${startTime.month.toString().padLeft(2, '0')}';
  }
}

abstract class ShowtimeRepository {
  Future<List<Showtime>> fetchShowtimes();
  Future<List<Showtime>> fetchShowtimesByDate(String date, int theaterId);
}

class ShowtimeRepositoryIml implements ShowtimeRepository {
  @override
  Future<List<Showtime>> fetchShowtimes() async {
    String api = '$serverUrl/showtime';
    print("API fetch Showtimes: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Showtimes');
    }

    final List<dynamic> showtimeJsonList = jsonDecode(response.body);
    return showtimeJsonList.map((json) => Showtime.fromJson(json)).toList();
  }

  @override
  Future<List<Showtime>> fetchShowtimesByDate(String date, int theaterId) async {
    String api = '$serverUrl/showtime/theater$theaterId/date$date';
    print("API fetch Showtimes by date: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Showtimes');
    }

    final List<dynamic> showtimeJsonList = jsonDecode(response.body);
    return showtimeJsonList.map((json) => Showtime.fromJson(json)).toList();
  }
}
