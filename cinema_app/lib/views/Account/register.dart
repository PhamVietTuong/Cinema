import 'package:cinema_app/data/DTO/res_get_code.dart';
import 'package:cinema_app/views/Account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:cinema_app/presenters/user_presenter.dart';
import 'package:cinema_app/components/text_field.dart';
import 'package:cinema_app/config.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent>
    implements UserViewContract {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  
  late UserPresenter _presenter;
  bool isMale = true;
 late String selectedGender;
  String textPass = "Mật khẩu";
  String textConfirmPass = "Nhập lại mật khẩu";
  String textbirthday = "Ngày sinh";
  String textRegister = "Đăng ký";
 late String textMale;
  String textWoman = "Nữ";
  String textErorr = "Lỗi";
  String textClose = Constants.textClose;
  String textSuccess = "Thành công";
 late List<String> gender;
  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textPass),
      Styles.translate(textConfirmPass),
      Styles.translate(textbirthday),
      Styles.translate(textRegister),
      Styles.translate(textMale),
      Styles.translate(textWoman),
      Styles.translate(textErorr),
      Styles.translate(textClose),
      Styles.translate(textSuccess),
      Styles.translate(selectedGender),
    ]);
    textPass = textTranlate[0];
    textConfirmPass = textTranlate[1];
    textbirthday = textTranlate[2];
    textRegister = textTranlate[3];
    textMale = textTranlate[4];
    textWoman = textTranlate[5];
    textErorr = textTranlate[6];
    textClose = textTranlate[7];
    textSuccess = textTranlate[8];
    selectedGender = textTranlate[9];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    textMale=Config.languageMode==Constants.codeVNKey?"Nam":"Nam giới";
    selectedGender=textMale;
    _presenter = UserPresenter(this);
    _birthdayController.text =
        DateTime.now().toLocal().toString().split(' ')[0];
    gender=[textMale,textWoman];
    tranlate();

  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_birthdayController.text),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  void _registerUser() {
    var register = Register(
      userName: _usernameController.text,
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      birthDay: DateTime.parse(_birthdayController.text),
      gender: isMale,
      userTypeName: 'user',
    );
    setState(() {
      //isLoad
    });
    _presenter.registerUser(register);
  }

  @override
  void onLoadError(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textErorr),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(textClose),
            ),
          ],
        );
      },
    );
  }

  @override
  void onRegisterSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textSuccess),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountScreen()),
                );
              },
              child: Text(textClose),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //  print(selectedGender);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Styles.defaultHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Styles.backgroundContent[Config.themeMode],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                InfoTextField(
                  textController: _usernameController,
                  icon: const Icon(Icons.person),
                  lableText: 'Tên đăng nhập',
                  readOnly: false,
                  obscurePassword: false,
                ),
                InfoTextField(
                  textController: _fullNameController,
                  icon: const Icon(Icons.person_pin),
                  lableText: 'Họ và tên',
                  readOnly: false,
                  obscurePassword: false,
                ),
                InfoTextField(
                  textController: _emailController,
                  icon: const Icon(Icons.email),
                  lableText: 'Email',
                  readOnly: false,
                  obscurePassword: false,
                ),
                InfoTextField(
                  textController: _phoneController,
                  icon: const Icon(Icons.phone),
                  lableText: 'Số điện thoại',
                  obscurePassword: false,
                  readOnly: false,
                ),
                InfoTextField(
                  textController: _passwordController,
                  icon: const Icon(Icons.password),
                  lableText: 'Mật khẩu',
                  obscurePassword: true,
                  readOnly: false,
                ),
                InfoTextField(
                  textController: _confirmPasswordController,
                  icon: const Icon(Icons.password),
                  lableText: 'Nhập lại mật khẩu',
                  obscurePassword: true,
                  readOnly: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: InfoTextField(
                      textController: _birthdayController,
                      icon: const Icon(Icons.date_range),
                      lableText: "Ngày sinh",
                      readOnly: true,
                      obscurePassword: false,
                      onTap: () {
                        _selectDate(context);
                        setState(() {
                          
                        });
                      },
                    )),
                    DropdownButton<String>(
                      value: selectedGender,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: Styles.titleFontSize,
                      elevation: 5,
                      dropdownColor: Styles.backgroundContent[Config.themeMode],
                      style: TextStyle(
                          color: Styles.boldTextColor[Config.themeMode]),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                          if (newValue == selectedGender) {
                            isMale = true;
                          } else {
                            isMale = false;
                          }
                        });
                      },
                      items:<String>[
                              textMale,
                              textWoman,
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: _registerUser,
                  child: Text(
                    textRegister,
                    style: const TextStyle(fontSize: Styles.titleFontSize),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // ignore: non_constant_identifier_names
  void loadLoginSuccess(User user) {}

  @override
  void loadUpdateSuccess(user) {}

  @override
  void onGetCodeSuccess(ResGetCode res) {
  }
  
  @override
  void onLoadToken(String token, DateTime expirationTime) {
  }
  
}
