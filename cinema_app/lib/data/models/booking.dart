import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/data/models/ticket_option.dart';

class Booking {
  Theater theater = Theater();
  Movie movie = Movie();

  List<TicketOption> tickets = List.filled(0, TicketOption(), growable: true);
  List<String> seatIds = List.filled(0, "", growable: true);
  ShowtimeRoom showtime = ShowtimeRoom();
  
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

  int getTotalPrice() {
    int result = 0;
    for (TicketOption opt in tickets) {
      result += (opt.quantity * opt.price);
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
        .where((e) => e.seatTypeName.compareTo("Đôi") == 0)
        .toList()
        .map((a) => a.quantity)
        .fold(0, (previousValue, element) => previousValue + element);
  }
}
