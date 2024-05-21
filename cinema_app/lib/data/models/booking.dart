import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/data/models/ticket_option.dart';

class Booking {
  Theater theater = Theater();
  Movie movie = Movie();

  List<TicketOption> tickets = List.filled(0, TicketOption(), growable: true);

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

  void resetCount() {
    for (TicketOption opt in tickets) {
      opt.count = 0;
    }
  }
}
