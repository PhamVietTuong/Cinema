// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cinema_app/data/models/age_restriction.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class Movie {
  int id;
  String name;
  int time;
  String description;
  String director;
  String actor;
  String trailer;
  String languages;
  String img;
  int status;

  AgeRestriction ageRestriction = AgeRestriction();
  DateTime releaseDate = DateTime.now();

  List<String> types = List.filled(0, "", growable: true);
  List<Showtime> showtimes = List.filled(0, Showtime(), growable: true);

  Movie(
      {this.id = 0,
      this.actor = "",
      this.description = "",
      this.director = "",
      this.img = "",
      this.languages = "",
      this.name = "",
      this.time = 0,
      this.trailer = "",
      this.status = 0});

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        actor = json["actor"] ?? "",
        description = json["description"] ?? "",
        director = json["director"] ?? "",
        img = json["image"] ?? "",
        languages = json["languages"] ?? "",
        name = json["name"] ?? "",
        releaseDate = DateTime.parse(json["release_date"]),
        time = json["time"] ?? 0,
        trailer = json["trailer"] ?? "",
        status = json["status"] ?? 0,
        ageRestriction = AgeRestriction(
          id: json["ar_id"] ?? 0,
          name: json["ar_name"] ?? "",
          description: json["ar_description"] ?? 0,
        ),
        types = json["movie_types"].split(',');
}

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies();
  Future<List<Movie>> fetchMoviesByIds(String ids);
}

class MovieRepositoryIml implements MovieRepository {
  @override
  Future<List<Movie>> fetchMovies() async {
    String api = '$serverUrl/movie/showing';
    print("API fetch movies: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch movies');
    }

    final List<dynamic> movieJsonList = jsonDecode(response.body);
    return movieJsonList.map((json) => Movie.fromJson(json)).toList();
  }

  @override
  Future<List<Movie>> fetchMoviesByIds(String ids) async {
    String api = '$serverUrl/movie/ids$ids';
    print("API fetch movies by ids: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch movies');
    }

    final List<dynamic> movieJsonList = jsonDecode(response.body);
    return movieJsonList.map((json) => Movie.fromJson(json)).toList();
  }
}
