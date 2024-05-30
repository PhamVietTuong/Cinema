// ignore_for_file: avoid_print

import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/data/models/seat_row.dart';
import '../data/injector.dart';

abstract class SeatViewContract {
  void onLoadSeatComplete(List<SeatRowData> seats);

  void onLoadSeatError();
}

class SeatPresenter {
  final SeatViewContract _view;
  late SeatRepository repository;

  SeatPresenter(this._view) {
    repository = Injector().getSeatRepository();
  }

  Future<void> fetchSeatsByRoomId(String roomId, String showtimeId) async {
    try {
      List<SeatRowData> seats =
          await repository.fetchSeatsByShowtimeIdAndRoomId(roomId, showtimeId);
      _view.onLoadSeatComplete(seats);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetch Seats By Showtimeid and RoomId: $error');
      _view.onLoadSeatError();
    }
  }
}
