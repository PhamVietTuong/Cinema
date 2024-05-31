// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/room.dart';

import '../../config.dart';
import 'package:http/http.dart' as http;

class Showtime {
  String id;
  String movieId;
  bool status;

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  Room room = Room();

  Showtime({this.id = "", this.movieId = "", this.status = false});

  Showtime.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        movieId = json['movieId'] ?? "",
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        status = json['status'] ?? 0;

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
  Future<List<Movie>> fetchShowtimesAndMoviesByDate(
       String theaterId) async {
    String api =
        '$serverUrl/api/Cinemas/GetShowTimeByTheaterId$theaterId';
    print("API fetch Showtimes by date: $api");

    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 204) return [];

    if (response.statusCode == 200) {
      final List<dynamic> jsons = jsonDecode(response.body);

      final List<Showtime> showtimes =
          List.filled(0, Showtime(), growable: true);
      final List<Movie> movies = List.filled(0, Movie(), growable: true);
      final Set<String> movieIds = {};

      for (var json in jsons) {
        Showtime s = Showtime.fromJson(json["showTime"]);
        s.room = Room.fromJson(json["room"]);

        // Thêm Movie vào danh sách nếu MovieId chưa tồn tại
        if (!movieIds.contains(json["showTime"]["movieId"])) {
          Movie m = Movie.fromJson(json["showTime"]["movie"]);
         
          movieIds.add(m.id);
          movies.add(m);
        }
      }
      return movies;
    } else {
      throw Exception(
          'Failed to fetch Showtimes: status code ${response.statusCode}');
    }
  }
}
