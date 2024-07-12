// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/services/base_url.dart';

import '../../config.dart';

class ShowtimeRoom {
  String roomId;
  String roomName;
  String showTimeId;
  int showtimeType;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  ShowtimeRoom({this.roomId = "", this.roomName = "", this.showTimeId = "", this.showtimeType=0});
  ShowtimeRoom.fromJson(Map<String, dynamic> json)
      : roomId = json["roomId"]??"",
        roomName = json["roomName"]??"",
        showTimeId = json["showTimeId"]??"",
        showtimeType=json["showTimeType"]??0,
        startTime = DateTime.parse(json["startTime"]),
        endTime = DateTime.parse(json["endTime"]);

  String getFormatTime() {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }

  String getFormatDate() {
    return '${startTime.day.toString().padLeft(2, '0')}/${startTime.month.toString().padLeft(2, '0')}';
  }
}

abstract class ShowtimeRepository {
  Future<List<Movie>> fetchShowtimesAndMoviesByDate(String theaterId);
}

class ShowtimeRepositoryIml implements ShowtimeRepository {
  @override
  Future<List<Movie>> fetchShowtimesAndMoviesByDate(String theaterId) async {
    String api = '$serverUrl/api/Cinemas/GetShowTimeByTheaterId$theaterId';
    print("API fetch Showtimes by date: $api");

    final response = await BaseUrl.get(api);
    if (response.statusCode == 204) return [];

    if (response.statusCode == 200) {
      final List<dynamic> jsons = jsonDecode(response.body);

      return jsons.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception(
          'Failed to fetch Showtimes: status code ${response.statusCode}');
    }
  }
}
