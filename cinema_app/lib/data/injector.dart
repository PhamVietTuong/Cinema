import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/data/models/user.dart';

import 'models/payment_request.dart';
import 'models/showtime.dart';
import 'models/theater.dart';
import 'models/ticket_option.dart';

class Injector {
  static final Injector _singleton = Injector._internal();
  factory Injector() {
    return _singleton;
  }
  Injector._internal();

  static TheaterRepository theaterRepoIml = TheaterRepositoryIml();
  static MovieRepository movieRepoIml = MovieRepositoryIml();
  static ShowtimeRepository showtimeRepoIml = ShowtimeRepositoryIml();
  static TicketRepository ticketRepoIml = TicketRepositoryIml();
  static SeatRepository seatRepoIml = SeatRepositoryIml();
  static UserRepository userRepoIml = UserRepositoryIml();
  static PaymentRepository paymentRepoIml = PaymentRepositoryIml();




  TheaterRepository getTheaterRepository() => theaterRepoIml;
  MovieRepository getMovieRepository() => movieRepoIml;
  ShowtimeRepository getShowtimeRepository() => showtimeRepoIml;
  TicketRepository getTicketRepository() => ticketRepoIml;
  SeatRepository getSeatRepository() => seatRepoIml;
  UserRepository getUserRepository() => userRepoIml;
  PaymentRepository getPaymentRepository() => paymentRepoIml;
}
