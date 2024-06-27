import 'package:cinema_app/views/Account/login_screen.dart';
import 'package:cinema_app/views/Account/register.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isLoginPage = true;
  final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Styles.gradientTop["dark_purple"]!,
      Styles.gradientBot["dark_purple"]!,
    ],
  );

  void _switchTab() {
    setState(() {
      _isLoginPage = !_isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Styles.boldTextColor["dark_purple"],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Đăng kí",
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor["dark_purple"],
          ),
        ),
        backgroundColor: Styles.backgroundContent["dark_purple"],
      ),
      backgroundColor: Styles.backgroundColor["dark_purple"],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTabButtons(),
            _isLoginPage ? RegisterContent() : LoginContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Styles.defaultHorizontal, vertical: 15),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _switchTab();
            },
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) - 20,
              padding: const EdgeInsets.all(10),
              decoration: _isLoginPage
                  ? BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(30),
                    )
                  : const BoxDecoration(
                      color: Colors.transparent,
                    ),
              child: Text(
                'Đăng ký',
                style: TextStyle(
                  color: Styles.boldTextColor["dark_purple"],
                  fontSize: Styles.titleFontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _switchTab();
            },
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) - 20,
              padding: const EdgeInsets.all(10),
              decoration: !_isLoginPage
                  ? BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(30),
                    )
                  : const BoxDecoration(
                      color: Colors.transparent,
                    ),
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Styles.boldTextColor["dark_purple"],
                  fontSize: Styles.titleFontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
