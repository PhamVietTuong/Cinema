// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';
import 'package:flutter/material.dart';

class ChangePassWordScreen extends StatefulWidget {
  const ChangePassWordScreen({super.key, required this.username});
  final String username;
  @override
  State<ChangePassWordScreen> createState() => _ChangePassWordScreenState();
}

class _ChangePassWordScreenState extends State<ChangePassWordScreen>
    implements UserViewContract {
  late UserPresenter _presenter;
  String textTitle = "Đổi mật khẩu";
  String textPass = "Nhập mật khẩu mới";
  String textConfirmPass = "Xác nhận mật khẩu mới";
  String textLablePass = "Mật khẩu mới";
  String textLableConfirmPass = "Xác nhận mật mới";
  String textConfirm = "Xác nhận";
  String textDesPass =
      "Mật phải chứa nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt";

  late TextEditingController pass;
  late TextEditingController confirmPass;
  Future<void> translate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textTitle),
      Styles.translate(textPass),
      Styles.translate(textConfirmPass),
      Styles.translate(textLablePass),
      Styles.translate(textLableConfirmPass),
      Styles.translate(textConfirm),
      Styles.translate(textDesPass),
    ]);
    textTitle = textTranlate[0];
    textPass = textTranlate[1];
    textConfirmPass = textTranlate[2];
    textLablePass = textTranlate[3];
    textLableConfirmPass = textTranlate[4];
    textConfirm = textTranlate[5];
    textDesPass = textTranlate[6];
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    pass.dispose();
    confirmPass.dispose();
  }

  @override
  void initState() {
    super.initState();
    _presenter = UserPresenter(this);
    translate();
    pass = TextEditingController();
    confirmPass = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.backgroundColor[Config.themeMode],
        appBar: AppBar(
          backgroundColor: Styles.backgroundContent[Config.themeMode],
          leading: IconButton(
            alignment: Alignment.center,
            onPressed: () {
              Navigator.pop(this.context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Styles.boldTextColor[Config.themeMode],
            ),
          ),
          title: Text(
            textTitle,
            style: TextStyle(
                color: Styles.boldTextColor[Config.themeMode],
                fontSize: Styles.appbarFontSize,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Styles.defaultHorizontal),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        textPass,
                        style: TextStyle(
                            fontSize: Styles.textSize,
                            color: Styles.textColor[Config.themeMode]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InfoTextField(
                      textController: pass,
                      icon: const Icon(Icons.password),
                      lableText: textLablePass,
                      readOnly: false,
                      obscurePassword: true),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        textConfirmPass,
                        style: TextStyle(
                            fontSize: Styles.textSize,
                            color: Styles.textColor[Config.themeMode]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InfoTextField(
                      textController: confirmPass,
                      icon: const Icon(Icons.password),
                      lableText: textLableConfirmPass,
                      readOnly: false,
                      obscurePassword: true),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Styles.btnColor[Config.themeMode],
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      onPressed: () {
                        print("Xác nhận");
                        _presenter.changePass(pass.text, confirmPass.text,
                            "0949866367a@gmail.com");
                      },
                      child: Text(
                        textConfirm,
                        style: TextStyle(
                            color: Styles.boldTextColor[Config.themeMode],
                            fontSize: Styles.textSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '*$textDesPass',
                    style: TextStyle(
                        color: Styles.boldTextColor[Config.themeMode],
                        fontSize: Styles.textSize,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void loadChangePassSuccess(bool res) {
    Navigator.pop(context);
  }

  @override
  void loadLoginSuccess(User user) {}

  @override
  void loadUpdateSuccess(User user) {}

  @override
  void onGetCodeSuccess(ResGetCode res) {}

  @override
  void onLoadError(String error) async {
    var textError = await Styles.translate(error);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(textError),
    ));
  }

  @override
  void onRegisterSuccess(String message) {}
}
