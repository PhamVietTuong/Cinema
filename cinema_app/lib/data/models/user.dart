// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cinema_app/config.dart';
import 'package:http/http.dart' as http;
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
 // Future<void> sendAuthCode(String email);
}

class UserRepositoryIml implements UserRepository {
//Handle event registration
  @override
  Future<void> register(Register register) async {
    final url = Uri.parse('$serverUrl/api/Users/Register');

    if (register.userName.isEmpty ||
        register.fullName.isEmpty ||
        register.password.isEmpty ||
        register.confirmPassword.isEmpty) {
      throw ('Tên người dùng, họ và tên, mật khẩu không được để trống.');
    }

    if (register.password != register.confirmPassword) {
      throw ('Mật khẩu và mật khẩu nhập lại không khớp.');
    }
    if(!isValidUsername(register.userName)){
      throw('Tên đăng nhập có độ dài từ 8 đến 20 ký tự, bao gồm  ký tự chữ cái, số và dấu gạch dưới và không có khoảng trắng');
    }
    if (!isValidPassword(register.password)) {
      throw ('Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.');
    }

    if (register.email.isNotEmpty && !isValidEmail(register.email)) {
      throw ('Địa chỉ email không hợp lệ.');
    }

    if (register.phone.isNotEmpty && !isValidPhone(register.phone)) {
      throw ('Số điện thoại không hợp lệ.');
    }

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(register.toJson()),
      );

      if (response.statusCode == 200) {
        print('Đăng ký thành công');
      } else {
        throw (response.body);
      }
    } catch (e) {
      throw ('$e');
    }
  }

  bool isValidPassword(String password) {
    final regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return regex.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    final regex = RegExp(r'^\d{10}$'); // Kiểm tra số điện thoại 10 chữ số
    return regex.hasMatch(phone);
  }

  bool isValidUsername(String username) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9_]{8,20}$');
    return regex.hasMatch(username);
  }
//end registration

//Handle event login
  @override
  Future<User> login(Login login) async {
    final url = Uri.parse('$serverUrl/api/Users/LoginUser');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(login.toJson()), // Chuyển đối tượng Login thành JSON
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return User.fromJson(jsonResponse); // Giải mã JSON thành đối tượng User
      } else {
       // print(response.body);
        throw (response.body);
      }
    } catch (e) {
      throw ('$e');
    }
  }

//end login
}
