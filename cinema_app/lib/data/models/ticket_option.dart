import 'package:cinema_app/data/models/seat_type.dart';
import 'package:cinema_app/data/models/ticket_type.dart';

class TicketOption {
  SeatType seatType = SeatType();
  TicketType ticketType = TicketType();
  int price;
  int quantity;
  int count;

  TicketOption(
      {SeatType? seatType, TicketType? ticketType, int? price, int? quantity})
      : seatType = seatType ?? SeatType(),
        ticketType = ticketType ?? TicketType(),
        price = price ?? 0,
        quantity = quantity ?? 0,
        count = 0;
  TicketOption.fromJson(Map<String, dynamic> json)
      : seatType = SeatType.fromJson(json["seatType"]),
        ticketType = TicketType.fromJson(json["ticketType"]),
        price = json["price"] ?? 0,
        quantity = 0,
        count = 0;

  String getName() {
    return '${seatType.name} ${ticketType.name}';
  }
}
