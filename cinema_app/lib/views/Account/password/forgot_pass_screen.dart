import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';
import 'package:cinema_app/views/Account/password/change_pass_screen.dart';
import 'package:flutter/material.dart';

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
  String textError = "Mã xác nhận không đúng";
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerCode = TextEditingController();

  Future<void> translate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textTitle),
      Styles.translate(textLabelEmail),
      Styles.translate(textSend),
      Styles.translate(textConfirm),
      Styles.translate(textLabelCode),
      Styles.translate(textCode)
    ]);
    textTitle = textTranlate[0];
    textLabelEmail = textTranlate[1];
    textSend = textTranlate[2];
    textConfirm = textTranlate[3];
    textLabelCode = textTranlate[4];
    textCode = textTranlate[5];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    translate();
    userPre = UserPresenter(this);
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
                        textLabelEmail,
                        style: TextStyle(
                            fontSize: Styles.textSize,
                            color: Styles.textColor[Config.themeMode]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _controllerEmail,
                    style: TextStyle(
                      fontSize: Styles.textSize,
                      color: Styles.textColor[Config.themeMode],
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: Styles.textSize,
                        color: Styles.textColor[Config.themeMode],
                      ),
                    ),
                  ),
                  Text(
                    resView == null || resView?.state == true
                        ? ""
                        : resView!.message,
                    style: TextStyle(
                        fontSize: Styles.textSize,
                        color: Styles.boldTextColor[Config.themeMode]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (resView?.state == true)
                    SizedBox(
                      child: Column(children: [
                        Row(
                          children: [
                            Text(
                              textLabelCode,
                              style: TextStyle(
                                  fontSize: Styles.textSize,
                                  color: Styles.textColor[Config.themeMode]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: _controllerCode,
                          style: TextStyle(
                            fontSize: Styles.textSize,
                            color: Styles.textColor[Config.themeMode],
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: textCode,
                            labelStyle: TextStyle(
                              fontSize: Styles.textSize,
                              color: Styles.textColor[Config.themeMode],
                            ),
                          ),
                        ),
                        Text(
                          textShowError,
                          style: TextStyle(
                              fontSize: Styles.textSize,
                              color: Styles.boldTextColor[Config.themeMode]),
                        ),
                      ]),
                    ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Styles.btnColor[Config.themeMode],
                        borderRadius: BorderRadius.circular(8)),
                    child: resView == null || resView?.state == false
                        ? TextButton(
                            onPressed: () {
                              userPre.sendAuthCode(_controllerEmail.text);
                            },
                            child: Text(
                              textSend,
                              style: TextStyle(
                                  fontSize: Styles.titleFontSize,
                                  color:
                                      Styles.boldTextColor[Config.themeMode]),
                            ))
                        : TextButton(
                            onPressed: () {
                              var code = _controllerCode.text.trim();
                              var resConfirm = resView!.message.compareTo(code);
                              if (resConfirm != 0) {
                                textShowError = textError;
                                resView!.message = "";
                                setState(() {});
                                return;
                              }
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChangePassWordScreen(),
                                  ));
                            },
                            child: Text(
                              textConfirm,
                              style: TextStyle(
                                  fontSize: Styles.titleFontSize,
                                  color:
                                      Styles.boldTextColor[Config.themeMode]),
                            )),
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
  void onLoadToken(String token, DateTime expirationTime) {}

  @override
  void onGetCodeSuccess(ResGetCode res) async {
    resView = res;
    if (resView!.state) {
    } else {
      resView!.message = await Styles.translate(res.message);
    }
    setState(() {
      translate();
    });
  }

  @override
  void onRegisterSuccess(String message) {}
  
  @override
  void loadLoginSuccess(User user) {
  }
  
  @override
  void loadUpdateSuccess(User user) {
  }
}
