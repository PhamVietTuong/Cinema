import 'dart:async';

import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';
import 'package:cinema_app/views/Account/password/change_pass_screen.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class FogotPassScreen extends StatefulWidget {
  const FogotPassScreen({super.key});

  @override
  State<FogotPassScreen> createState() => _FogotPassScreenState();
}

class _FogotPassScreenState extends State<FogotPassScreen>
    implements UserViewContract {
  late UserPresenter userPre;
  ResGetCode? resView;
  String textTitle = "Quên mật khẩu";
  String textLabelEmail = "Nhập email để đặt lại mật khẩu";
  String textSend = "Gửi";
  String textConfirm = "Xác nhận";
  String textLabelCode = "Nhập mã xác nhận để đổi mật khẩu";
  String textCode = "Mã xác nhận";
  String textShowError = "";
  String textErrorCode = "Mã xác nhận không đúng";
  String textSendAction = "Đã gửi mã về email";
  String textSendAgain = "Gửi lại";
  String textCodeTimeOut = "Mã xác nhận đã hết hạn. Vui lòng gửi lại";

  int timeDefault = 30;
  late int timePause;

  int timeCodeDefault = 90;
  late int timeCode;
  bool isButtonEnabled = true;
  bool isTimeIn = false;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerCode = TextEditingController();

  Future<void> translate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textTitle),
      Styles.translate(textLabelEmail),
      Styles.translate(textSend),
      Styles.translate(textConfirm),
      Styles.translate(textLabelCode),
      Styles.translate(textCode),
      Styles.translate(textErrorCode),
      Styles.translate(textSendAction),
      Styles.translate(textSendAgain),
      Styles.translate(textCodeTimeOut),
    ]);
    textTitle = textTranlate[0];
    textLabelEmail = textTranlate[1];
    textSend = textTranlate[2];
    textConfirm = textTranlate[3];
    textLabelCode = textTranlate[4];
    textCode = textTranlate[5];
    textErrorCode = textTranlate[6];
    textSendAction = textTranlate[7];
    textSendAgain = textTranlate[8];
    textCodeTimeOut = textTranlate[9];
    setState(() {});
  }

  pause() async {
    while (timePause > 0 && !isButtonEnabled) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timePause--;
      });
    }
    setState(() {
      isButtonEnabled = true;
      timePause = timeDefault;
    });
  }

  countDownTimeCode() async {
    while (timeCode > 0&&isTimeIn) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timeCode--;
      });
    }
    setState(() {
      isTimeIn = false;
      timeCode = timeCodeDefault;
      resView!.message = "";
      textShowError = textCodeTimeOut;
    });
  }

  @override
  void initState() {
    super.initState();
    translate();
    timePause = timeDefault;
    timeCode = timeCodeDefault;
    userPre = UserPresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Styles.backgroundColor[Config.themeMode],
      appBar: AppBar(
        backgroundColor: Styles.backgroundContent[Config.themeMode],
        leading: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            setState(() {
              isButtonEnabled = true;
              isTimeIn = false;
            });
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
              width: wS,
              padding: const EdgeInsets.symmetric(
                  horizontal: Styles.defaultHorizontal),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        textLabelEmail,
                        style: TextStyle(
                            fontSize: Styles.textSize,
                            color: Styles.textColor[Config.themeMode]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InfoTextField(
                          textController: _controllerEmail,
                          icon: const Icon(Icons.email),
                          lableText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Styles.btnColor[Config.themeMode],
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextButton(
                                  onPressed: isButtonEnabled
                                      ? () {
                                          setState(() {
                                            isButtonEnabled = false;
                                            textShowError =
                                                ""; // Vô hiệu hóa nút khi đếm ngược bắt đầu
                                          });
                                          pause();
                                          userPre
                                              .sendAuthCode(
                                                _controllerEmail.text.trim(),
                                              )
                                              .then((value) => {
                                                    showSimpleNotification(
                                                      Text(
                                                        textSendAction,
                                                        style: TextStyle(
                                                            fontSize: Styles
                                                                .titleFontSize,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Styles
                                                                    .boldTextColor[
                                                                Config
                                                                    .themeMode]),
                                                      ),
                                                      background: Styles
                                                              .backgroundContent[
                                                          Config.themeMode],
                                                      autoDismiss: true,
                                                      duration: const Duration(
                                                          seconds: 2),
                                                      slideDismissDirection:
                                                          DismissDirection.up,
                                                    )
                                                  });
                                        }
                                      : null,
                                  child: Text(
                                    textSend,
                                    style: TextStyle(
                                        fontSize: Styles.titleFontSize,
                                        color: Styles
                                            .boldTextColor[Config.themeMode]),
                                  ))),
                          const SizedBox(
                            height: 10,
                          ),
                          timePause != timeDefault
                              ? Text(
                                  "$textSendAgain($timePause)",
                                  style: TextStyle(
                                      color: Styles.textColor[Config.themeMode],
                                      fontSize: Styles.textSize),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    resView == null || resView?.state == true
                        ? ""
                        : resView!.message,
                    style: TextStyle(
                        fontSize: Styles.textSize,
                        color: Styles.boldTextColor[Config.themeMode]),
                  ),
                  if (resView?.state == true)
                    SizedBox(
                      child: Column(children: [
                        Row(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              textLabelCode,
                              style: TextStyle(
                                  fontSize: Styles.textSize,
                                  color: Styles.textColor[Config.themeMode]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InfoTextField(
                                  textController: _controllerCode,
                                  icon: const Icon(Icons.vpn_key),
                                  lableText: textCode),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Styles.btnColor[Config.themeMode],
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextButton(
                                  onPressed: () {
                                    var code = _controllerCode.text.trim();
                                    var resConfirm =
                                        resView!.message.compareTo(code);
                                    if (resConfirm != 0) {
                                      textShowError = textErrorCode;
                                      resView!.message = "";
                                      setState(() {});
                                      return;
                                    }
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                               ChangePassWordScreen(username: _controllerEmail.text.trim()),
                                        ));
                                  },
                                  child: Text(
                                    textConfirm,
                                    style: TextStyle(
                                        fontSize: Styles.titleFontSize,
                                        color: Styles
                                            .boldTextColor[Config.themeMode]),
                                  )),
                            ),
                          ],
                        ),
                        Text(
                          textShowError,
                          style: TextStyle(
                              fontSize: Styles.textSize,
                              color: Styles.boldTextColor[Config.themeMode]),
                        ),
                      ]),
                    ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  void onLoadError(String error) {}


  @override
  void onGetCodeSuccess(ResGetCode res) async {
    resView = res;
    if (resView!.state) {
      isTimeIn = true;
      countDownTimeCode();
    } else {
      resView!.message = await Styles.translate(res.message);
    }
    setState(() {});
  }

  @override
  void onRegisterSuccess(String message) {}

  @override
  void loadLoginSuccess(User user) {}

  @override
  void loadUpdateSuccess(User user) {}
  
  @override
  void loadChangePassSuccess(bool res) {
  }
}
