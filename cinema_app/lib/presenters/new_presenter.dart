import 'package:cinema_app/data/injector.dart';
import 'package:cinema_app/data/models/new.dart';

abstract class NewViewContract {
  void onLoadNewComplete(List<News> New);
  void onLoadError();
}

class NewPresenter {
  final NewViewContract _view;
  late final NewRepository _repository;

  NewPresenter(this._view) {
    _repository = Injector().getNewRepository();
  }

  Future<void> fetchNew() async {
    try {
      final List<News> news = await _repository.getNewModels();
      _view.onLoadNewComplete(news);
    } catch (error) {
      _view.onLoadError();
    }
  }
}
