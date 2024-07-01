import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    implements UserViewContract {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late UserPresenter _presenter;
  String? _token;

  @override
  void initState() {
    super.initState();
    _presenter = UserPresenter(this); // Khởi tạo _presenter trong initState
    _loadToken();
  }

  Future<User> login(Login login) {
    return _presenter.login(login); // Gọi phương thức login từ _presenter
  }

  @override
  void onLoadError(String error) {
    // Xử lý khi có lỗi
  }

  @override
  void onLoadSuccess(String token) {
    _saveTokenToLocal(token);
  }

  void _saveTokenToLocal(String token) async {
    await Config.saveToken(token);
    setState(() {
      _token = token;
    });
    print('Token : $token');
  }

  void _loadToken() {
    setState(() {
      _token = Config.getToken();
    });
  }

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
        const SizedBox(height: 15),
        InfoTextField(
          title: "Tên đăng nhập",
          info: _usernameController,
          icon: const Icon(Icons.person),
        ),
        const SizedBox(height: 15),
        InfoTextField(
          title: "Mật khẩu",
          info: _passController,
          icon: const Icon(Icons.password),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            String username = _usernameController.text;
            String password = _passController.text;

            if (username.isEmpty || password.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Thông báo'),
                    content:
                        const Text('Vui lòng điền đầy đủ thông tin đăng nhập'),
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
            login(loginInfo).then((user) {
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ],
                  );
                },
              );
            }).catchError((e) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Thông báo'),
                    content: Text('$e'),
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
            });
          },
          child: const Text(
            'Đăng nhập',
            style: TextStyle(fontSize: Styles.titleFontSize),
          ),
        )
      ],
    );
  }
}
