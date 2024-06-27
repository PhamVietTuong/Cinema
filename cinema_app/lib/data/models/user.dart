import 'dart:convert';

import 'package:cinema_app/config.dart';
import 'package:http/http.dart' as http;

class User {
  int id;
  String fullname;
  String phone;
  String email;
  String address;
  DateTime birthday;
  String image;
  bool gender;
  int status;
  String username;

  User({
    this.id = 0,
    this.fullname = "",
    this.phone = "",
    this.email = "",
    this.address = "",
    DateTime? birthday,
    this.image = "",
    this.gender = false,
    this.status = 0,
    this.username = "",
  }) : birthday = birthday ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      fullname: json["name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      address: json["address"] ?? "",
      birthday: json["birthday"] != null
          ? DateTime.parse(json["birthday"])
          : DateTime.now(),
      image: json["image"] ?? "",
      gender: json["gender"] ?? false,
      status: json["status"] ?? 0,
      username: json["username"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullname": fullname,
      "phone": phone,
      "email": email,
      "address": address,
      "birthday": birthday.toIso8601String(),
      "image": image,
      "gender": gender,
      "status": status,
      "username": username,
    };
  }
}

class Register {
  final String UserTypeName;
  final String userName;
  final String fullName;
  final String email;
  final String phone;
  final DateTime birthDay;
  final String password;
  final String confirmPassword;
  final bool gender;

  Register({
    required this.UserTypeName,
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
      UserTypeName: json['UserTypeName'] ?? '',
      userName: json['userName'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      birthDay: json["birthDay"] != null ? DateTime.parse(json["birthDay"]) : DateTime.now(),
      password: json['password'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
      gender: json['gender'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserTypeName': UserTypeName,
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

class RegistrationException implements Exception {
  final String message;
  RegistrationException(this.message);

  @override
  String toString() => 'RegistrationException: $message';
}

abstract class UserRepository {
  Future<void> register(Register register);
}

class UserRepositoryIml implements UserRepository {
  @override
Future<void> register(Register register) async {
    final url = Uri.parse('$serverUrl/api/Users/Register');

    if (register.userName.isEmpty ||
        register.fullName.isEmpty ||
        register.password.isEmpty ||
        register.confirmPassword.isEmpty) {
      throw RegistrationException(
          'Tên người dùng, họ và tên, mật khẩu không được để trống.');
    }

    if (register.password != register.confirmPassword) {
      throw RegistrationException('Mật khẩu và mật khẩu nhập lại không khớp.');
    }

    if (!isValidPassword(register.password)) {
      throw RegistrationException(
          'Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.');
    }

    if (register.email.isNotEmpty && !isValidEmail(register.email)) {
      throw RegistrationException('Địa chỉ email không hợp lệ.');
    }

    if (register.phone.isNotEmpty && !isValidPhone(register.phone)) {
      throw RegistrationException('Số điện thoại không hợp lệ.');
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
        throw RegistrationException('Đăng ký thất bại: ${response.body}');
      }
    } catch (e) {
      throw RegistrationException('Đăng ký người dùng thất bại: $e');
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
}