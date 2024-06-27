import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            'Đăng nhập vào hệ thống',
            style: TextStyle(
              fontSize: Styles.titleFontSize,
              color: Styles.boldTextColor["dark_purple"],
            ),
          ),
        SizedBox(height: 15),
        // Replace with your login form or content
        InfoTextField(
          title: "Tên đăng nhập",
          info: _usernameController,
          icon: Icon(Icons.person),
        ),
        SizedBox(height: 15),
        InfoTextField(
          title: "Mật khẩu",
          info: _passController,
          icon: Icon(Icons.password),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle login logic here
          },
          child: Text('Đăng nhập'),
        ),
      ],
    );
  }
}
