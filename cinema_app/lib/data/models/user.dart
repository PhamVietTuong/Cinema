// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:cinema_app/data/DTO/update_user.dart';
import 'package:cinema_app/data/models/validation.dart';
import 'package:cinema_app/services/base_url.dart';

class User {
  String id;
  String fullname;
  String phone;
  String email;
  DateTime birthday;
  String image;
  bool gender;
  int status;
  String username;
  String token;
  DateTime expirationTime;

  User({
    required this.id,
    this.fullname = "",
    this.phone = "",
    this.email = "",
    DateTime? birthday,
    this.image = "",
    this.gender = false,
    this.status = 0,
    this.username = "",
    this.token = "",
    DateTime? expirationTime,
  })  : birthday = birthday ?? DateTime.now(),
        expirationTime = expirationTime ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? "",
      fullname: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      birthday: json["birthday"] != null
          ? DateTime.parse(json["birthday"])
          : DateTime.now(),
      image: json["image"] ?? "",
      gender: json["gender"] ?? false,
      status: json["status"] ?? 0,
      username: json["userName"] ?? "",
      token: json["token"] ?? "",
      expirationTime: json["expirationTime"] != null
          ? DateTime.parse(json["expirationTime"])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullname,
      "phone": phone,
      "email": email,
      "birthday": birthday.toIso8601String(),
      "image": image,
      "gender": gender,
      "status": status,
      "userName": username,
      "token": token,
      "expirationTime": expirationTime.toIso8601String(),
    };
  }
}

class Register {
  final String userTypeName;
  final String userName;
  final String fullName;
  final String email;
  final String phone;
  final DateTime birthDay;
  final String password;
  final String confirmPassword;
  final bool gender;

  Register({
    required this.userTypeName,
    required this.userName,
    required this.fullName,
    required this.password,
    required this.confirmPassword,
    required this.email,
    required this.phone,
    required this.birthDay,
    required this.gender,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      userTypeName: json['userTypeName'] ?? '',
      userName: json['userName'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      birthDay: json["birthDay"] != null
          ? DateTime.parse(json["birthDay"])
          : DateTime.now(),
      password: json['password'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
      gender: json['gender'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userTypeName': userTypeName,
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'birthDay': birthDay.toIso8601String(),
      'password': password,
      'confirmPassword': confirmPassword,
      'gender': gender,
    };
  }
}

class Login {
  final String username;
  final String password;

  Login({
    required this.username,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      username: json['username'] ?? "",
      password: json['password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

abstract class UserRepository {
  Future<void> register(Register register);
  Future<User> login(Login login);
  Future<ResGetCode> sendAuthCode(String email);
  Future<User> updateUser(User user);

  Future<bool> changePass(String pass, String username);
}

class UserRepositoryIml implements UserRepository {
//Handle event registration
  @override
  Future<void> register(Register register) async {
    final url = '$serverUrl/api/Users/Register';

    if (register.userName.trim().isEmpty ||
        register.fullName.trim().isEmpty ||
        register.password.trim().isEmpty ||
        register.confirmPassword.trim().isEmpty ||
        register.email.trim().isEmpty||
        register.phone.trim().isEmpty||
        register.birthDay.toString().isEmpty
        ) {
      throw ('Tên người dùng, họ và tên, email, số điện thoại, ngày sinh, mật khẩu không được để trống.');
    }
    if (register.password != register.confirmPassword) {
      throw ('Mật khẩu và mật khẩu nhập lại không khớp.');
    }
    if (!Validation.isValidUsername(register.userName)) {
      throw ('Tên đăng nhập có độ dài từ 8 đến 20 ký tự, bao gồm  ký tự chữ cái, số và dấu gạch dưới và không có khoảng trắng');
    }
    if (!Validation.isValidPassword(register.password)) {
      throw ('Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.');
    }
    if (!Validation.isValidEmail(register.email)) {
      throw ('Địa chỉ email không hợp lệ.');
    }
    if (!Validation.isValidPhone(register.phone)) {
      throw ('Số điện thoại không hợp lệ.');
    }
    try {
      final response = await BaseUrl.post(url, jsonEncode(register.toJson()));
      if (response.statusCode == 200) {
        print('Đăng ký thành công');
      } else {
        throw (response.body);
      }
    } catch (e) {
      throw ('$e');
    }
  }
//end registration

//Handle event login
  @override
  Future<User> login(Login login) async {
    final url = '$serverUrl/api/Users/LoginUser';
    try {
      final response = await BaseUrl.post(url, jsonEncode(login.toJson()));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return User.fromJson(jsonResponse); // Giải mã JSON thành đối tượng User
      } else {
        // print(response.body);
        // print(response.body);
        throw (response.body);
      }
    } catch (e) {
      throw ('$e');
    }
  }

  @override
  Future<UpdateUser> updateUser(UpdateUser user) async {
    final url = '$serverUrl/api/Users/UpdateUser';
    try {
      final response = await BaseUrl.post(url, jsonEncode(user.toJson()));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonDecode(response.body));
        return UpdateUser.fromJson(jsonResponse);
      } else {
        // print(response.body);
        throw (response.body);
      }
    } catch (e) {
      throw ('$e');
    }
  }

//end login

//SendAuthCode
  @override
  Future<ResGetCode> sendAuthCode(String email) async {
    final url = '$serverUrl/api/Users/SendAuthCode';
    try {
      final response = await BaseUrl.post(url, jsonEncode({'email': email}));
      if (response.statusCode == 200) {
        print('Đã gửi mã xác thực thành công.');
        return ResGetCode.formJson(jsonDecode(response.body));
      } else {
        print('Gửi mã xác thực thất bại. Mã lỗi: ${response.statusCode}');
        throw (response.body);
      }
    } catch (e) {
      print(e);
      throw ('$e');
    }
  }

  @override
  Future<bool> changePass(String pass, String username) async {
    final url =
        '$serverUrl/api/Users/ChangePassword?changePassword=$pass&userName=$username';
    try {
      final body = jsonEncode({
        'userName': username,
        'changePassword': pass,
      });

      final response = await BaseUrl.post(url, body);
      if (response.statusCode == 200) {
        print('Đổi mật khẩu thành công');
        return true;
      } else {
        print('Đổi mật khẩu thất bại. Mã lỗi: ${response.statusCode}');
        throw (response.body);
      }
    } catch (e) {
      print(e);
      throw ('$e');
    }
  }

// //end SendAuthCode
}
