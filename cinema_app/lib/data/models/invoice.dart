import 'dart:convert';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/services/base_url.dart';

class Invoice {
  String movieImage;
  String movieName;
  String projectionFormText;
  String ageRestrictionName;
  String ageRestrictionDescription;
  String theaterName;
  String code;
  DateTime showTimeStartTime;
  String roomName;
  int numberTicket;
  String showTimeType;
  String seatName;
  double totalPrice;
  List<FoodAndDrink> foodAndDrinks;
  String theaterAddress;

  Invoice({
    this.movieImage = "",
    this.movieName = "",
    this.projectionFormText = "",
    this.ageRestrictionName = "",
    this.ageRestrictionDescription = "",
    this.theaterName = "",
    this.code = "",
    DateTime? showTimeStartTime,
    this.roomName = "",
    this.numberTicket = 0,
    this.showTimeType = "",
    this.seatName = "",
    this.totalPrice = 0.0,
    this.foodAndDrinks = const [],
    this.theaterAddress = "",
  }) : showTimeStartTime = showTimeStartTime ?? DateTime.now();

  Invoice.fromJson(Map<String, dynamic> json)
      : movieImage = json["movieImage"] ?? "",
        movieName = json["movieName"] ?? "",
        projectionFormText = json["projectionFormText"] ?? "",
        ageRestrictionName = json["ageRestrictionName"] ?? "",
        ageRestrictionDescription = json["ageRestrictionDescription"] ?? "",
        theaterName = json["theaterName"] ?? "",
        code = json["code"] ?? "",
        showTimeStartTime = DateTime.parse(json["showTimeStartTime"] ?? DateTime.now().toIso8601String()),
        roomName = json["roomName"] ?? "",
        numberTicket = json["numberTicket"] ?? 0,
        showTimeType = json["showTimeType"] ?? "",
        seatName = json["seatName"] ?? "",
        totalPrice = (json["totalPrice"] ?? 0.0).toDouble(),
        theaterAddress = json["theaterAddress"] ?? "",
        foodAndDrinks = json["foodAndDrinks"] != null
            ? (json["foodAndDrinks"] as List)
                .map((e) => FoodAndDrink.fromJson(e as Map<String, dynamic>))
                .toList()
            : [];

  Map<String, dynamic> toJson() {
    return {
      "movieImage": movieImage,
      "movieName": movieName,
      "projectionFormText": projectionFormText,
      "ageRestrictionName": ageRestrictionName,
      "ageRestrictionDescription": ageRestrictionDescription,
      "theaterName": theaterName,
      "code": code,
      "showTimeStartTime": showTimeStartTime.toIso8601String(),
      "roomName": roomName,
      "numberTicket": numberTicket,
      "showTimeType": showTimeType,
      "seatName": seatName,
      "totalPrice": totalPrice,
      "foodAndDrinks": foodAndDrinks.map((e) => e.toJson()).toList(),
      "theaterAddress": theaterAddress,
    };
  }
}

class FoodAndDrink {
  final String foodAndDrinkName;
  final int quantity;

  FoodAndDrink({
    required this.foodAndDrinkName,
    required this.quantity,
  });

  factory FoodAndDrink.fromJson(Map<String, dynamic> json) {
    return FoodAndDrink(
      foodAndDrinkName: json['foodAndDrinkName'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodAndDrinkName': foodAndDrinkName,
      'quantity': quantity,
    };
  }
}

abstract class InvoiceRepository {
  Future<List<Invoice>> invoice();
}

class InvoiceRepositoryIml implements InvoiceRepository {
  @override
  Future<List<Invoice>> invoice() async {
    final url = '$serverUrl/api/Cinemas/GetInvoiceList/${Config.userInfo?.id}';
    final response = await BaseUrl.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch invoices');
    }

    final List<dynamic> invoiceJsonList = jsonDecode(response.body);
    return invoiceJsonList.map((json) => Invoice.fromJson(json)).toList();
  }
}
