// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/food_and_drink.dart';
import 'package:http/http.dart' as http;

class Theater {
  String id;
  String name;
  String address;
  String phone;
  String img;
  bool status;

  List<FoodAndDrink> combos = List.filled(0, FoodAndDrink(), growable: true);

  Theater(
      {this.id = "",
      this.name = "",
      this.address = "",
      this.phone = "",
      this.img = "",
      this.status = false});

  Theater.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'] ?? "",
        name = json['name'] ?? "",
        img = json['image'] ?? "",
        phone = json['phone'] ?? "",
        status = json['status'] ?? false;
}

abstract class TheaterRepository {
  Future<List<Theater>> fetchTheaters();
  Future<List<FoodAndDrink>> fetchCombosByTheater(String theaterId);
}

class TheaterRepositoryIml implements TheaterRepository {
  @override
  Future<List<Theater>> fetchTheaters() async {
    String api = '$serverUrl/api/Cinemas/GetTheaterList';
    print("API fetch theates: $api");

    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 204) return [];
    if (response.statusCode == 200) {
      final List<dynamic> theaterJsonList = jsonDecode(response.body);
      return theaterJsonList.map((json) => Theater.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch theaters');
    }
  }

  @override
  Future<List<FoodAndDrink>> fetchCombosByTheater(String theaterId) async {
    String api = '$serverUrl/api/Cinemas/ComboByTheaterId/$theaterId';
    print("API fetch combos: $api");

    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 204) return [];
    if (response.statusCode == 200) {
      final List<dynamic> comboJsonList = jsonDecode(response.body);
      return comboJsonList.map((json) => FoodAndDrink.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch combos');
    }
  }
}
