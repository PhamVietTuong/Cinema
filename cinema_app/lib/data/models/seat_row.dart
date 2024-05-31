import 'package:cinema_app/data/models/seat.dart';

class SeatRowData {
  String rowName;
  List<Seat> seats = List.filled(0, Seat(), growable: true);

  SeatRowData({this.rowName = ""});

  SeatRowData.fromJson(Map<String, dynamic> json)
      : rowName = json["rowName"],
        seats =
            (json["rowSeats"] as List).map((e) => Seat.fromJson(e)).toList();
}
