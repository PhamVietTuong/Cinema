import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/data/models/ticket_option.dart';

import 'movie.dart';

class Booking {
  Theater theater = Theater();
  Movie movie = Movie();
  ShowtimeRoom showtime = ShowtimeRoom();

  List<TicketOption> tickets = List.filled(0, TicketOption(), growable: true);
  List<Seat> seats = List.filled(0, Seat(), growable: true);

  Booking({Theater? theater, Movie? movie})
      : theater = theater ?? Theater(),
        movie = movie ?? Movie();

  int getTotalTickets() {
    int result = 0;
    for (TicketOption opt in tickets) {
      result += opt.quantity;
    }
    return result;
  }

  int getPriceTickets() {
    int result = 0;

    for (TicketOption opt in tickets) {
      result += (opt.quantity * opt.price);
    }
    return result;
  }

  int getPriceCombos() {
    int result = 0;

    for (var item in theater.combos) {
      result += (item.quantity * item.price);
    }
    return result;
  }

  int getTotalPrice() {
    return getPriceTickets() + getPriceCombos();
  }

  int getTotalCombo() {
    int result = 0;
    for (var item in theater.combos) {
      result += item.quantity;
    }
    return result;
  }

  int countingSignle() {
    return tickets
        .where((e) => e.seatTypeName.compareTo("Đơn") == 0)
        .toList()
        .map((a) => a.quantity)
        .fold(0, (previousValue, element) => previousValue + element);
  }

  int countingCouple() {
    return tickets
        .where((e) => e.seatTypeName.compareTo("Ðôi") == 0)
        .toList()
        .map((a) => a.quantity)
        .fold(0, (previousValue, element) => previousValue + element);
  }
}
