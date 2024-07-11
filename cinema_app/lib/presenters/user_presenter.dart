import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:cinema_app/data/injector.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/data/models/validation.dart';

abstract class UserViewContract {
  void onLoadError(String error);
  void onRegisterSuccess(String message);
  void onGetCodeSuccess(ResGetCode res);
  void loadUpdateSuccess(User user);
  void loadLoginSuccess(User user);
  void loadChangePassSuccess(bool res);
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
      _view.onRegisterSuccess('Đăng ký thành công');
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

  Future<void> sendAuthCode(String email) async {
    try {
      ResGetCode res = await repository.sendAuthCode(email);
      _view.onGetCodeSuccess(res);
    } catch (e) {
      _view.onLoadError('$e');
      throw ('$e');
    }
  }

  Future<void> changePass(
      String pass, String passConfirm, String username) async {
    try {
      if (pass.isEmpty || passConfirm.isEmpty) {
        _view.onLoadError('Không được để trống thông tin');
        return;
      }
      if (!Validation.isValidPassword(pass) ||
          !Validation.isValidPassword(passConfirm)) {
        _view.onLoadError('Mật khẩu không đúng định dạng');
        return;
      }
      if (pass != passConfirm) {
        _view.onLoadError('Mật khẩu xác nhận không khớp');
        return;
      }
      bool res = await repository.changePass(pass, username);
      _view.loadChangePassSuccess(res);
    } catch (e) {
      _view.onLoadError("Đổi mật khẩu thất bại");
      throw ('$e');
    }
  }
}
