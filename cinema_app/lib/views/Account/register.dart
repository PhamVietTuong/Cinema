import 'package:flutter/material.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';
import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/config.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

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
  bool isMale = true;
  String selectedGender = 'Nam';

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
      gender: isMale,
      userTypeName: 'user',
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
              child: const Text('Đóng'),
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
          title: const Text('Thành công'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Styles.defaultHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(bottom: 15),
            decoration: BoxDecoration(
              color: Styles.backgroundContent[Config.themeMode],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                InfoTextField(
                    info: _usernameController,
                    icon: const Icon(Icons.person),
                    title: 'Tên đăng nhập'),
                const SizedBox(height: 15),
                InfoTextField(
                    info: _fullNameController,
                    icon: const Icon(Icons.person_pin),
                    title: 'Họ và tên'),
                const SizedBox(height: 15),
                InfoTextField(
                    info: _emailController,
                    icon: const Icon(Icons.email),
                    title: 'Email'),
                const SizedBox(height: 15),
                InfoTextField(
                    info: _phoneController,
                    icon: const Icon(Icons.phone),
                    title: 'Số điện thoại'),
                const SizedBox(height: 15),
                TextField(
                  style: TextStyle(color: Styles.boldTextColor[Config.themeMode]),
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.lock),
                    labelStyle:
                        TextStyle(color: Styles.boldTextColor[Config.themeMode]),
                    prefixIconColor: Styles.boldTextColor[Config.themeMode],
                    focusColor: Styles.boldTextColor[Config.themeMode],
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
                  style: TextStyle(color: Styles.boldTextColor[Config.themeMode]),
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
                    prefixIcon: const Icon(Icons.lock),
                    labelStyle:
                        TextStyle(color: Styles.boldTextColor[Config.themeMode]),
                    prefixIconColor: Styles.boldTextColor[Config.themeMode],
                    focusColor: Styles.boldTextColor[Config.themeMode],
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                            color: Styles.boldTextColor[Config.themeMode]),
                        controller: _birthdayController,
                        onTap: () {
                          _selectDate(context);
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Ngày sinh',
                          prefixIcon: const Icon(Icons.calendar_today),
                          labelStyle: TextStyle(
                              color: Styles.boldTextColor[Config.themeMode]),
                          prefixIconColor: Styles.boldTextColor[Config.themeMode],
                          focusColor: Styles.boldTextColor[Config.themeMode],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedGender,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: Styles.titleFontSize,
                      elevation: 5,
                      dropdownColor: Styles.backgroundContent[Config.themeMode],
                      style:
                          TextStyle(color: Styles.boldTextColor[Config.themeMode]),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                          if (newValue == 'Nam') {
                            isMale = true;
                          } else {
                            isMale = false;
                          }
                        });
                      },
                      items: isMale
                          ? <String>[
                              'Nam',
                              'Nữ',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : <String>[
                              'Nữ',
                              'Nam',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: _registerUser,
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: Styles.titleFontSize),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
