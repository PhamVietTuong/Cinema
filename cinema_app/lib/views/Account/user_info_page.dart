import 'dart:convert';

import 'package:cinema_app/components/bottom_nav.dart';
import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:cinema_app/presenters/user_presenter.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/user.dart';

// ignore: must_be_immutable
class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key? key, required this.infoUser}) : super(key: key);
  User infoUser;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage>
    implements UserViewContract {
  String textAppBar = "Thông tin người dùng";
  String textSignOut = "Đăng xuất";
  String textTitleSignOut = "Xác nhận đăng xuất";
  String textContent = "Bạn có chắc chắn muốn đăng xuất không?";
  String textUpdate = "Cập nhật thông tin";
  String textClose = Constants.textClose;
  late UserPresenter _presenter;

  bool isEditing = false; // State variable to track edit mode

//  late TextEditingController userName;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController birthDay;
  late TextEditingController gender;

  @override
  void initState() {
    super.initState();
    //  userName = TextEditingController(text: widget.infoUser.username);
    fullName = TextEditingController(text: widget.infoUser.fullname);
    email = TextEditingController(text: widget.infoUser.email);
    phone = TextEditingController(text: widget.infoUser.phone);
    birthDay = TextEditingController(
        text: widget.infoUser.birthday.toLocal().toString().split(' ')[0]);
    gender = TextEditingController(text: widget.infoUser.gender ? "Nam" : "Nữ");
    translate();
    _presenter = UserPresenter(this);
  }

  Future<void> translate() async {
    List<String> textTranslate = await Future.wait([
      Styles.translate(textAppBar),
      Styles.translate(textSignOut),
      Styles.translate(textTitleSignOut),
      Styles.translate(textContent),
      Styles.translate(textClose),
      Styles.translate(textUpdate),
    ]);
    setState(() {
      textAppBar = textTranslate[0];
      textSignOut = textTranslate[1];
      textTitleSignOut = textTranslate[2];
      textContent = textTranslate[3];
      textClose = textTranslate[4];
      textUpdate = textTranslate[5];
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(birthDay.text),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthDay.text = picked.toLocal().toString().split(' ')[0];
      });
    }
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
                Navigator.of(context).popUntil((route) => route.isFirst);
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

  void handleSave() {
    final updatedUser = User(
      username: Config.userInfo!.username,
      fullname: fullName.text,
      email: email.text,
      phone: phone.text,
      birthday: DateTime.parse(birthDay.text),
      id: Config.userInfo!.id,
      status: 1,
    );

    print('Updating user with: ${jsonEncode(updatedUser.toJson())}');

    _presenter.updateUser(updatedUser);
  }

  @override
  void loadLoginSuccess(User user) {
    // Handle login success if needed
  }

  @override
  void loadUpdateSuccess(User user) {
    setState(() {
      isEditing = false;
      widget.infoUser = user;
    });
    Config.saveInfoUser(user);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cập nhật thông tin thành công!')),
    );
  }

  @override
  void onGetCodeSuccess(ResGetCode res) {}

  @override
  void onLoadError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Có lỗi xảy ra: $error')),
    );
  }

  @override
  void onLoadToken(String token, DateTime expirationTime) {}

  @override
  void onRegisterSuccess(String message) {}

  @override
  Widget build(BuildContext context) {
    print( Config.userInfo!.username,);
    print(widget.infoUser.fullname);

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
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.save),
              color: Styles.boldTextColor[Config.themeMode],
              onPressed: handleSave,
            ),
        ],
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
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                    icon: Icon(isEditing ? Icons.close : Icons.edit),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // InfoTextField(
              //   textController: userName,
              //   lableText: 'Tên đăng nhập',
              //   icon: const Icon(Icons.person_2_rounded),
              //   readOnly: !isEditing,
              //   obscurePassword: false,
              // ),
              InfoTextField(
                textController: fullName,
                lableText: 'Họ và tên',
                readOnly: !isEditing,
                icon: const Icon(Icons.person_pin),
                obscurePassword: false,
              ),
              InfoTextField(
                textController: email,
                lableText: 'Email',
                readOnly: !isEditing,
                icon: const Icon(Icons.email_outlined),
                obscurePassword: false,
              ),
              InfoTextField(
                textController: phone,
                lableText: 'Số điện thoại',
                readOnly: !isEditing,
                icon: const Icon(Icons.phone),
                obscurePassword: false,
              ),
              InfoTextField(
                textController: birthDay,
                lableText: 'Sinh nhật',
                readOnly: !isEditing,
                onTap: () => isEditing ? _selectDate(context) : null,
                icon: const Icon(Icons.date_range),
                obscurePassword: false,
              ),
              InfoTextField(
                textController: gender,
                lableText: 'Giới tính',
                readOnly: !isEditing,
                icon: gender.text == "Nam"
                    ? const Icon(Icons.male_outlined)
                    : const Icon(Icons.female),
                obscurePassword: false,
              ),
              const SizedBox(height: 20),
              if (!isEditing)
                OutlinedButton(
                  onPressed: handleLogout,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Styles.boldTextColor[Config.themeMode]!,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
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
            ],
          ),
        ),
      ),
    );
  }
}
