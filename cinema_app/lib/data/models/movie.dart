// ignore_for_file: avoid_print

//import 'dart:convert';
import 'dart:convert';

import 'package:cinema_app/config.dart';
import 'package:http/http.dart' as http;

import 'showtime.dart';
// import '../../constants.dart';


class Movie {
  String id;
  String ageRestrictionName;
  String ageRestrictionDescription;
  String ageRestrictionAbbreviation;
  String name;
  int time;
  String description;
  String director;
  String actor;
  String trailer;
  String languages;
  String img;
  String movieType;
  String showTimeTypeName;
  int projectionForm;

  DateTime releaseDate = DateTime.now();

  List<Schedule> schedules = List.filled(0, Schedule(), growable: true);

  Movie({
    this.id = "",
    this.ageRestrictionAbbreviation = "",
    this.ageRestrictionDescription = "",
    this.ageRestrictionName = "",
    this.actor = "",
    this.description = "",
    this.director = "",
    this.img = "",
    this.languages = "",
    this.name = "",
    this.movieType = "",
    this.showTimeTypeName = "",
    this.time = 0,
    this.trailer = "",
    this.projectionForm = 0,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"]??"",
        actor = json["actor"] ?? "",
        ageRestrictionAbbreviation = json["ageRestrictionAbbreviation"] ?? "",
        ageRestrictionDescription = json["ageRestrictionDescription"] ?? "",
        ageRestrictionName = json["ageRestrictionName"] ?? "",
        description = json["description"] ?? "",
        director = json["director"] ?? "",
        img = json["image"] ?? "",
        movieType = json["movieType"] ?? "",
        showTimeTypeName = json["showTimeTypeName"] ?? "",
        languages = json["languages"] ?? "",
        name = json["name"] ?? "",
        releaseDate = DateTime.parse(json["releaseDate"]),
        time = json["time"] ?? -1,
        trailer = json["trailer"] ?? "",
        projectionForm = json["projectionForm"] ?? 0;
}

class Schedule {
  DateTime date = DateTime.now();
  List<TheaterShowtime> theaters =
      List.filled(0, TheaterShowtime(), growable: true);
  List<ShowtimeRoom> showtimes = List.filled(0, ShowtimeRoom(), growable: true);

  Schedule();
  Schedule.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json["date"]),
        theaters =json["theaters"]!=null?(json["theaters"] as List)
            .map((e) => TheaterShowtime.fromJson(e as Map<String, dynamic>))
            .toList():[],
        showtimes =json["showtimes"]!=null? (json["showtimes"] as List)
            .map((e) => ShowtimeRoom.fromJson(e as Map<String, dynamic>))
            .toList():[];
}

class TheaterShowtime {
  String theaterName;
  String theaterAddress;
  List<ShowtimeRoom> showtimes = List.filled(0, ShowtimeRoom(), growable: true);

  TheaterShowtime({this.theaterName = "", this.theaterAddress = ""});
  TheaterShowtime.fromJson(Map<String, dynamic> json)
      : theaterAddress = json["theaterAddress"] ?? "",
        theaterName = json["theaterName"] ?? "",
        showtimes = (json["showTimes"] as List)
            .map((e) => ShowtimeRoom.fromJson(e as Map<String, dynamic>))
            .toList();
}


abstract class MovieRepository {
  Future<List<Movie>> fetchMovies();
  Future<Movie> fetchMovieDetail(String movieID, int projectionForm);
}

class MovieRepositoryIml implements MovieRepository {
  @override
  Future<List<Movie>> fetchMovies() async {
    String api = '$serverUrl/api/Cinemas/GetMovieList';
    // print("API fetch movies: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch movies');
    }

    final List<dynamic> movieJsonList = jsonDecode(response.body);
    return movieJsonList.map((json) => Movie.fromJson(json)).toList();
  }

  @override
  Future<Movie> fetchMovieDetail(String movieID, int projectionForm) async {
    String api = '$serverUrl/api/Cinemas/MovieDetail';

    final response = await http.post(Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"id": movieID, "projectionForm": projectionForm}));

    if (response.statusCode == 200) {
      final dynamic movieJson = jsonDecode(response.body);
      return Movie.fromJson(movieJson);
    } else {
      throw Exception(
          'Failed to fetch movie detail, status code: ${response.statusCode}');
    }
  }
}
