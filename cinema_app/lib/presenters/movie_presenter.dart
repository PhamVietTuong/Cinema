import 'package:cinema_app/data/injector.dart';
import 'package:cinema_app/data/models/movie.dart';

abstract class MovieViewContract {
  void onLoadMoviesComplete(List<Movie> movies);
  void onLoadMoviesError();
}

class MoviePresenter {
  final MovieViewContract _view;
  late MovieRepository _repository;

  MoviePresenter(this._view) {
    _repository = Injector().getMovieRepository();
  }

  Future<void> fetchMovies() async {
    try {
      List<Movie> movies = await _repository.fetchMovies();
      _view.onLoadMoviesComplete(movies);
    } catch (error) {
      print('Error fetching movies: $error');
      _view.onLoadMoviesError();
    }
  }
}
