// ignore_for_file: avoid_print

//import 'dart:convert';
 import 'dart:convert';

import 'package:cinema_app/config.dart';
import 'package:http/http.dart' as http;
// import '../../constants.dart';

import 'package:cinema_app/data/models/showtime.dart';

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
        movieType = json["movieType"] ??"",
        showTimeTypeName = json["showTimeTypeName"] ??"",
        languages = json["languages"] ?? "",
        name = json["name"] ?? "",
        releaseDate = DateTime.parse(json["releaseDate"]) ,
        time = json["time"] ?? -1,
        trailer = json["trailer"] ?? "",
        schedules=(json["schedules"] as List).map((e) => Schedule.fromJson(e as Map<String, dynamic>)).toList();
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
        showtimes = (json["showTimes"] as List<ShowtimeRoom>)
            .map((e) => ShowtimeRoom.fromJson(e as Map<String, dynamic>))
            .toList();
}

class ShowtimeRoom {
  String roomId;
  String roomName;
  String showTimeId;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  ShowtimeRoom({this.roomId = "", this.roomName = "", this.showTimeId = ""});
  ShowtimeRoom.fromJson(Map<String, dynamic> json)
      : roomId = json["roomId"],
        roomName = json["roomName"],
        showTimeId = json["showTimeId"],
        startTime = DateTime.parse(json["startTime"]),
        endTime = DateTime.parse(json["endTime"]);

  String getFormatTime() {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }

  String getFormatDate() {
    return '${startTime.day.toString().padLeft(2, '0')}/${startTime.month.toString().padLeft(2, '0')}';
  }
}

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies();
}

class MovieRepositoryIml implements MovieRepository {
  @override
  Future<List<Movie>> fetchMovies() async {
    String api ='$serverUrl/api/Cinemas/GetMovieList';
    print("API fetch movies: $api");

    final response = await http.get(Uri.parse(api));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch movies');
    }

    final List<dynamic> movieJsonList = jsonDecode(response.body);
    return movieJsonList.map((json) => Movie.fromJson(json)).toList();
  }
}