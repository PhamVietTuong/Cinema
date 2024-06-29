import 'package:flutter/material.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';
import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/config.dart';

class RegisterContent extends StatefulWidget {
  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent>
    implements UserViewContract {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late UserPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = UserPresenter(this);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = picked.toIso8601String();
      });
    }
  }

  Future<void> _registerUser() async {
    var register = Register(
      userName: _usernameController.text,
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      birthDay: DateTime.parse(_birthdayController.text),
      gender: true,
      UserTypeName: 'user', // Thay thế bằng userTypeId từ API
    );

    await _presenter.registerUser(register);
  }

  @override
  void onLoadError(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  void onLoadSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thành công'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InfoTextField(
              info: _usernameController,
              icon: Icon(Icons.person),
              title: 'Tên đăng nhập'),
          const SizedBox(height: 15),
          InfoTextField(
              info: _fullNameController,
              icon: Icon(Icons.person_pin),
              title: 'Họ và tên'),
          const SizedBox(height: 15),
          InfoTextField(
              info: _emailController,
              icon: Icon(Icons.email),
              title: 'Email'),
          const SizedBox(height: 15),
          InfoTextField(
              info: _phoneController,
              icon: Icon(Icons.phone),
              title: 'Số điện thoại'),
          const SizedBox(height: 15),
          TextField(
            style: TextStyle(color: Styles.boldTextColor["dark_purple"]),
            controller: _birthdayController,
            onTap: () {
              _selectDate(context);
            },
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Ngày sinh',
              prefixIcon: Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            style: TextStyle(color: Styles.boldTextColor["dark_purple"]),
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Icon(
                  _obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            style: TextStyle(color: Styles.boldTextColor["dark_purple"]),
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              labelText: 'Nhập lại mật khẩu',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureConfirmPassword =
                        !_obscureConfirmPassword;
                  });
                },
                child: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _registerUser,
            child: Text('Đăng ký'),
          ),
        ],
      ),
    );
  }
}
