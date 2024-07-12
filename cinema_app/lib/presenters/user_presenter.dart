import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:cinema_app/data/injector.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/data/models/validation.dart';

import '../data/DTO/update_user.dart';

abstract class UserViewContract {
  void onLoadError(String error);
  void onRegisterSuccess(String message);
  void onGetCodeSuccess(ResGetCode res);
  void loadUpdateSuccess(UpdateUser user);
  void loadLoginSuccess(User user);
  void onLoadToken(String token, DateTime expirationTime);
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
      print(user.birthday);
      // print(user.expirationTime);
    } catch (e) {
      _view.onLoadError('$e');
      throw ('$e');
    }
  }

  Future<void> updateUser(UpdateUser userInfo) async {
    try {
      if (!Validation.isValidEmail(userInfo.email)) {
        _view.onLoadError('error');
        return;
      }
        if (!Validation.isValidPhone(userInfo.phone)) {
        _view.onLoadError('error');
        return;
      }
      
      if (userInfo.id.trim().isEmpty ||
          userInfo.fullname.trim().isEmpty ||
          userInfo.phone.trim().isEmpty ||
          userInfo.email.trim().isEmpty ||
          userInfo.birthday.toString().isEmpty) {
        _view.onLoadError('error');
        return;
      }

      UpdateUser user = await repository.updateUser(userInfo);
      print('Updating user with: ${userInfo.toJson()}');
      _view.loadUpdateSuccess(user);
    } catch (e) {
      print('Error : $e');
      _view.onLoadError('$e');
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
}
