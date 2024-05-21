// ignore_for_file: avoid_print


import '../data/injector.dart';
import '../data/models/theater.dart';

abstract class TheaterViewContract {
  void onLoadTheaterComplete(List<Theater> theaters);
  void onLoadTheaterError();
}

class TheaterPresenter {
  final TheaterViewContract _view;
  late TheaterRepository repository;

  TheaterPresenter(this._view) {
    repository = Injector().getTheaterRepository();
  }

  Future<void> fetchTheaters() async {
    try {
      List<Theater> theaters = await repository.fetchTheaters();
      _view.onLoadTheaterComplete(theaters);
    //  _view.onLoadTheaterError();

    } catch (error) {
      // Xử lý lỗi
      print('Error fetching theaters: $error');
      _view.onLoadTheaterError();
    }
  }
}
