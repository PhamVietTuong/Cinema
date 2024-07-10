import 'package:cinema_app/components/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';

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
  String textNotification = "Thông báo";
  String textContent = "Vui lòng điền đủ thông tin đăng nhập";
  String textLoginSuccessful = "Đăng nhập thành công";
  String textOK = "Đồng ý";

  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textPass),
      Styles.translate(textLogin),
      Styles.translate(textNotification),
      Styles.translate(textContent),
      Styles.translate(textLoginSuccessful),
      Styles.translate(textOK),
    ]);
    textPass = textTranlate[0];
    textLogin = textTranlate[1];
    textNotification = textTranlate[2];
    textContent = textTranlate[3];
    textLoginSuccessful = textTranlate[4];
    textOK = textTranlate[5];

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
          title: Text(textNotification),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              child: Text(textOK),
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
  void loadLoginSuccess(User user) {
    Config.saveInfoUser(user);
    showDialogOnLoadSuccess(user);
  }

  @override
  void onLoadSuccess(String message) {}
  void showDialogOnLoadSuccess(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textNotification),
          content: Text(textLoginSuccessful),
          actions: <Widget>[
            TextButton(
              child: Text(textOK),
              onPressed: () {
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                );

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Styles.defaultHorizontal),
      decoration: BoxDecoration(
        color: Styles.backgroundContent[Config.themeMode],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InfoTextField(
            lableText: "Tên đăng nhập",
            textController: _usernameController,
            icon: const Icon(Icons.person),
            readOnly: false,
            obscurePassword: false,
          ),
          InfoTextField(
              textController: _passwordController,
              icon: const Icon(Icons.password),
              lableText: 'Mật khẩu',
              readOnly: false,
              obscurePassword: true),
          ElevatedButton(
            onPressed: () {
              String username = _usernameController.text;
              String password = _passwordController.text;
              if (username.isEmpty || password.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(textNotification),
                      content: Text(textContent),
                      actions: <Widget>[
                        TextButton(
                          child: Text(textOK),
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
  void loadUpdateSuccess(user) {}
}
