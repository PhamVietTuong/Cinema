import 'package:cinema_app/data/injector.dart';
import 'package:cinema_app/data/models/user.dart';

abstract class UserViewContract {
  void onLoadError(String error);
  void onLoadSuccess(String message);
  void loadLoginSuccess(User user);
  void loadUpdateSuccess(user);
}

class UserPresenter {
  final UserViewContract _view;
  late UserRepository repository;

  UserPresenter(this._view) {
    repository = Injector().getUserRepository();
  }

  Future<void> registerUser(Register register) async {
    try {
      await repository.register(register);
      _view.onLoadSuccess('Đăng ký thành công');
    } catch (e) {
      _view.onLoadError('$e');
    }
  }

  Future<void> login(Login login) async {
    try {
      User user = await repository.login(login);
      _view.loadLoginSuccess(user);
      // print(user.expirationTime);
    } catch (e) {
      _view.onLoadError('$e');
      throw ('$e');
    }
  }

  Future<void> updateUser(User userInfo) async {
    try {
      User user = await repository.updateUser(userInfo);
      _view.loadUpdateSuccess(user);
      // print(user.expirationTime);
    } catch (e) {
      _view.onLoadError('$e');
      throw ('$e');
    }
  }
}
