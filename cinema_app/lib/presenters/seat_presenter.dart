// ignore_for_file: avoid_print

import 'package:cinema_app/data/models/seat.dart';
import '../data/injector.dart';

abstract class SeatViewContract {
  void onLoadSeatComplete(List<Seat> seats);
  void onLoadSeatIsSoldComplete(List<Seat> seats);

  void onLoadSeatError();
}

class SeatPresenter {
  final SeatViewContract _view;
  late SeatRepository repository;

  SeatPresenter(this._view) {
    repository = Injector().getSeatRepository();
  }

  Future<void> fetchSeatsByRoomId(int roomId) async {
    try {
      List<Seat> seats = await repository.fetchSeatsByRoomId(roomId);
      _view.onLoadSeatComplete(seats);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetch Seats By RoomId: $error');
      _view.onLoadSeatError();
    }
  }

  Future<void> fetchSeatsInTicketsByShowtimeId(int showtimeId) async {
    try {
      List<Seat> seats = await repository.fetchSeatsInTicketsByShowtimeId(showtimeId);
      _view.onLoadSeatIsSoldComplete(seats);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetch Seats In Tickets By ShowtimeId: $error');
      _view.onLoadSeatError();
    }
  }
}
