import 'package:cinema_app/components/bottom_nav.dart';
import 'package:cinema_app/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/user.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key, required this.infoUser});
  final User infoUser;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String textAppBar = "Thông tin người dùng";
  String textSignOut = "Đăng xuất";
  String textTitleSignOut = "Xác nhận đăng xuất";
  String textContent = "Bạn có chắc chắn muốn đăng xuất không?";
  String textUpdate = "Cập nhật thông tin";
  String textClose = Constants.textClose;
  bool status = true;
  late TextEditingController userName;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController birthDay;
  late TextEditingController gender;

  void translate() async {
    List<String> textTranslate = await Future.wait([
      Styles.translate(textAppBar),
      Styles.translate(textSignOut),
      Styles.translate(textTitleSignOut),
      Styles.translate(textContent),
      Styles.translate(textClose),
      Styles.translate(textUpdate),
    ]);
    textAppBar = textTranslate[0];
    textSignOut = textTranslate[1];
    textTitleSignOut = textTranslate[2];
    textContent = textTranslate[3];
    textClose = textTranslate[4];
    textUpdate = textTranslate[5];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    userName = TextEditingController(text: widget.infoUser.username);
    fullName = TextEditingController(text: widget.infoUser.fullname);
    email = TextEditingController(text: widget.infoUser.email);
    phone = TextEditingController(text: widget.infoUser.phone);
    birthDay =
        TextEditingController(text: widget.infoUser.birthday.toIso8601String());
    gender = TextEditingController(text: widget.infoUser.gender ? "Nam" : "Nữ");
    translate();
  }

  void handleLogout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textTitleSignOut),
          content: Text(textContent),
          actions: <Widget>[
            TextButton(
              child: Text(textClose),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(textSignOut),
              onPressed: () async {
                await Config.logOut();
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                ); // Đóng dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNav()),
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
          textAppBar,
          style: TextStyle(
            color: Styles.boldTextColor[Config.themeMode],
            fontSize: Styles.appbarFontSize,
          ),
        ),
        backgroundColor: Styles.backgroundContent[Config.themeMode],
      ),
      backgroundColor: Styles.backgroundColor[Config.themeMode],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/img/user.png',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height * 0.1,
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.infoUser.fullname,
                    style: TextStyle(
                      color: Styles.boldTextColor[Config.themeMode],
                      fontSize: Styles.iconSizeInTitle,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        status = false;
                        print("yy");
                        setState(() {});
                      },
                      icon: const Icon(Icons.edit)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              InfoTextField(
                textController: userName,
                lableText: 'Tên đăng nhập',
                icon: const Icon(Icons.person_2_rounded),
                readOnly: status,
                obscurePassword: false,
              ),
              InfoTextField(
                textController: fullName,
                lableText: 'Họ và tên',
                readOnly: status,
                icon: const Icon(Icons.person_pin),
                obscurePassword: false,
              ),
              InfoTextField(
                textController: email,
                lableText: 'Email',
                readOnly: status,
                icon: const Icon(Icons.email_outlined),
                obscurePassword: false,
              ),
              InfoTextField(
                textController: phone,
                lableText: 'Số điện thoại',
                readOnly: status,
                icon: const Icon(Icons.phone),
                obscurePassword: false,
              ),
              InfoTextField(
                textController: birthDay,
                lableText: 'Sinh nhật',
                readOnly: status,
                icon: const Icon(Icons.date_range),
                obscurePassword: false,
              ),
              InfoTextField(
                textController: gender,
                lableText: 'Giới tính',
                readOnly: status,
                icon: gender.toString().contains("Nam")
                    ? const Icon(Icons.male_outlined)
                    : const Icon(Icons.female),
                obscurePassword: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      handleLogout();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Styles.boldTextColor[
                            Config.themeMode]!, // Màu của đường viền
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Độ cong của góc
                      ),
                    ),
                    child: Text(
                      textSignOut,
                      style: TextStyle(
                        color: Styles.boldTextColor[Config.themeMode],
                        fontSize: Styles.titleFontSize,
                      ),
                    ),
                  ),
                  status != true
                      ? OutlinedButton(
                          onPressed: () {
                            status = true;
                            setState(() {});
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Styles.boldTextColor[
                                  Config.themeMode]!, // Màu của đường viền
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Độ cong của góc
                            ),
                          ),
                          child: Text(
                            textUpdate,
                            style: TextStyle(
                              color: Styles.boldTextColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
