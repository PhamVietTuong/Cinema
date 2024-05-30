// ignore_for_file: avoid_print

import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/showtime.dart';

import '../data/injector.dart';

abstract class ShowtimeViewContract {
  void onLoadShowtimeAndMovieComplete(List<Movie> movies);
  void onLoadShowtimeError();
}

class ShowtimePresenter {
  final ShowtimeViewContract _view;
  late ShowtimeRepository repository;

  ShowtimePresenter(this._view) {
    repository = Injector().getShowtimeRepository();
  }

  Future<void> fetchShowtimesByDate( String theaterId) async {
 //   String dayString = '${date.year}-${date.month}-${date.day}';
    try {
      List<Movie> movies =
          await repository.fetchShowtimesAndMoviesByDate( theaterId);
      _view.onLoadShowtimeAndMovieComplete(movies);
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching Showtimes and movies by Date: $error');
      _view.onLoadShowtimeError();
    }
  }
}
