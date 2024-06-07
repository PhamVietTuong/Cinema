import 'package:cinema_app/data/injector.dart';
import 'package:cinema_app/data/models/movie.dart';

abstract class MovieViewContract {
  void onLoadMoviesComplete(List<Movie> movies);
  void onLoadMovieDetailComplete(Movie movies);
  void onLoadError();
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
      // print('Error fetching movies: $error');
      _view.onLoadError();
    }
  }

  Future<void> fetchMovieDetail(String movieID, int projectionForm) async {
    try {
      Movie movies =
          await _repository.fetchMovieDetail(movieID, projectionForm);
      _view.onLoadMovieDetailComplete(movies);
    } catch (error) {
      // print('Error fetching moviesdetail: $error');
      _view.onLoadError();
    }
  }
}
