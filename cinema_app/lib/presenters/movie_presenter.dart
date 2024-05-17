// ignore_for_file: avoid_print

import '../data/injector.dart';
import '../data/models/movie.dart';

abstract class MovieViewContract {
  void onLoadMovieComplete(List<Movie> movies);
  void onLoadMovieError();
}

class MoviePresenter {
  final MovieViewContract _view;
  late MovieRepository repository;

  MoviePresenter(this._view) {
    repository = Injector().getMovieRepository();
  }

  Future<void> fetchMovies() async {
    try {
      List<Movie> movies = await repository.fetchMovies();
      _view.onLoadMovieComplete(movies);
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching movies: $error');
      _view.onLoadMovieError();
    }
  }

  Future<void> fetchMoviesByIds(List<int> ids) async {
    String idsString = ids.join(',');
    try {
      List<Movie> movies = await repository.fetchMoviesByIds(idsString);
      _view.onLoadMovieComplete(movies);
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching movies: $error');
      _view.onLoadMovieError();
    }
  }
}
