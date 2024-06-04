import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/seat.dart';

import 'models/showtime.dart';
import 'models/theater.dart';
import 'models/room.dart';
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
  static RoomRepository roomRepoIml = RoomRepositoryIml();
  static TicketRepository ticketRepoIml = TicketRepositoryIml();
  static SeatRepository seatRepoIml = SeatRepositoryIml();


  TheaterRepository getTheaterRepository() => theaterRepoIml;
  MovieRepository getMovieRepository() => movieRepoIml;
  ShowtimeRepository getShowtimeRepository() => showtimeRepoIml;
  RoomRepository getRoomRepository() => roomRepoIml;
  TicketRepository getTicketRepository() => ticketRepoIml;
  SeatRepository getSeatRepository() => seatRepoIml;
}
