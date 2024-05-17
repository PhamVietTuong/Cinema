// ignore_for_file: avoid_print

import 'package:cinema_app/data/models/showtime.dart';

import '../data/injector.dart';

abstract class ShowtimeViewContract {
  void onLoadShowtimeComplete(List<Showtime> showtimes);
  void onLoadShowtimeError();
}

class ShowtimePresenter {
  final ShowtimeViewContract _view;
  late ShowtimeRepository repository;

  ShowtimePresenter(this._view) {
    repository = Injector().getShowtimeRepository();
  }

  Future<void> fetchShowtimes() async {
    try {
      List<Showtime> showtimes = await repository.fetchShowtimes();
      _view.onLoadShowtimeComplete(showtimes);
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching Showtimes: $error');
      _view.onLoadShowtimeError();
    }
  }

  Future<void> fetchShowtimesByDate(DateTime date, int theaterId) async {
    String dayString = '${date.year}-${date.month}-${date.day}';
    try {
      List<Showtime> showtimes =
          await repository.fetchShowtimesByDate(dayString, theaterId);
      _view.onLoadShowtimeComplete(showtimes);
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching Showtimes by Date: $error');
      _view.onLoadShowtimeError();
    }
  }
}
