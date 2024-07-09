import 'package:cinema_app/views/Account/login.dart';
import 'package:cinema_app/views/Account/register.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String textLogin = "Đăng kí";
  String textRegister = "Đăng nhập";
  String textAccount = "Tài Khoản";

  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textLogin),
      Styles.translate(textRegister),
      Styles.translate(textAccount),
    ]);
    textLogin = textTranlate[0];
    textRegister = textTranlate[1];
    textAccount = textTranlate[2];
    setState(() {});
  }

  bool _isLoginPage = true;
  final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Styles.gradientTop[Config.themeMode]!,
      Styles.gradientBot[Config.themeMode]!,
    ],
  );

  void _switchTab() {
    setState(() {
      _isLoginPage = !_isLoginPage;
    });
  }

  @override
  void initState() {
    super.initState();
    tranlate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Styles.boldTextColor[Config.themeMode],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          textAccount,
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor[Config.themeMode],
          ),
        ),
        backgroundColor: Styles.backgroundContent[Config.themeMode],
      ),
      backgroundColor: Styles.backgroundColor[Config.themeMode],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTabButtons(),
            _isLoginPage ? const RegisterContent() : const LoginContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: Styles.defaultHorizontal, vertical: 15),
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
                textRegister,
                style: TextStyle(
                  color: Styles.boldTextColor[Config.themeMode],
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
                textLogin,
                style: TextStyle(
                  color: Styles.boldTextColor[Config.themeMode],
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
