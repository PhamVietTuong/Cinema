import 'package:cinema_app/components/bottom_nav.dart';
import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';

import 'password/forgot_pass_screen.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    implements UserViewContract {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late UserPresenter _presenter;
  String textPass = "Mật khẩu";
  String textLogin = "Đăng nhập";
  String textForgetPass = "Quêt mật khẩu";
  bool _obscurePassword = true;
  String? _token;
  DateTime? _tokenExpirationTime;
  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textPass),
      Styles.translate(textLogin),
      Styles.translate(textForgetPass),
    ]);
    textPass = textTranlate[0];
    textLogin = textTranlate[1];
    textForgetPass = textTranlate[2];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _presenter = UserPresenter(this);
    tranlate();
  }

  @override
  void onLoadError(String error) {
    // Xử lý khi có lỗi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onLoginSuccess(User user) {
    Config.saveInfoUser(user);
    showDialogOnLoadSuccess(user);
  }
  
  void showDialogOnLoadSuccess(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Đăng nhập thành công'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNav()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _saveTokenToLocal(String token, DateTime expirationTime) async {
    // await Config.saveToken(token, expirationTime);
    setState(() {
      _token = token;
      _tokenExpirationTime = expirationTime;
    });
    print('Token : $_token , $_tokenExpirationTime');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Styles.defaultHorizontal),
      padding: const EdgeInsetsDirectional.only(bottom: 15, top: 10),
      decoration: BoxDecoration(
        color: Styles.backgroundContent[Config.themeMode],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InfoTextField(
            title: "Tên đăng nhập",
            info: _usernameController,
            icon: const Icon(Icons.person),
          ),
          const SizedBox(height: 15),
          TextField(
            style: TextStyle(color: Styles.boldTextColor[Config.themeMode]),
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: textPass,
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
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FogotPassScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 0.5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Styles.boldTextColor[Config.themeMode]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text(
                    textForgetPass,
                    style: TextStyle(
                      fontSize: Styles.titleFontSize,
                      color: Styles.boldTextColor[Config.themeMode],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              String username = _usernameController.text;
              String password = _passwordController.text;

              if (username.isEmpty || password.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thông báo'),
                      content: const Text(
                          'Vui lòng điền đầy đủ thông tin đăng nhập'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                return;
              }
              Login loginInfo = Login(username: username, password: password);
              _presenter.login(loginInfo);
            },
            child: Text(
              textLogin,
              style: const TextStyle(fontSize: Styles.titleFontSize),
            ),
          )
        ],
      ),
    );
  }

  @override
  void onLoadToken(String token, DateTime expirationTime) {
    _saveTokenToLocal(token, expirationTime);
  }

  @override
  void onGetCodeSuccess(ResGetCode res) {
  }

  @override
  void onRegisterSuccess(String message) {
  }
}
