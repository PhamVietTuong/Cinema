import 'package:cinema_app/components/bottom_nav.dart';
import 'package:cinema_app/components/text_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/user.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({super.key, required this.InfoUser});
  final User InfoUser;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String textAppBar = "Thông tin người dùng";
  String textSignOut = "Đăng xuất";
  String textTitleSignOut="Xác nhận đăng xuất";
  String textContent="Bạn có chắc chắn muốn đăng xuất không?";
  String textClose=Constants.textClose;

  void translate() async {
    List<String> textTranslate = await Future.wait([
      Styles.translate(textAppBar),
      Styles.translate(textSignOut),
      Styles.translate(textTitleSignOut),
      Styles.translate(textContent),
      Styles.translate(textClose),



    ]);
    textAppBar = textTranslate[0];
    textSignOut=textTranslate[1];
    textTitleSignOut=textTranslate[2];
    textContent=textTranslate[3];
    textClose=textTranslate[4];
    setState(() {});
  }

  void initState() {
    super.initState();
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
              Navigator.of(context).popUntil((route) => route.isFirst,); // Đóng dialog
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
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/img/user.png',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height * 0.1,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                widget.InfoUser.fullname,
                style: TextStyle(
                  color: Styles.boldTextColor[Config.themeMode],
                  fontSize: Styles.iconSizeInTitle,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFieldController(
                textController: widget.InfoUser.username,
                textName: 'Tên đăng nhập',
                status: true,
              ),
              TextFieldController(
                textController: widget.InfoUser.fullname,
                textName: 'Họ và tên',
                status: true,
              ),
              TextFieldController(
                textController: widget.InfoUser.email,
                textName: 'Email',
                status: true,
              ),
              TextFieldController(
                textController: widget.InfoUser.phone,
                textName: 'Số điện thoại',
                status: true,
              ),
              TextFieldController(
                textController: Styles.formatDate(widget.InfoUser.birthday),
                textName: 'Sinh nhật',
                status: true,
              ),
              TextFieldController(
                textController: widget.InfoUser.gender ? "Nữ" : "Nam",
                textName: 'Giới tính',
                status: true,
              ),
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
                      )
            ],
          ),
        ),
      ),
    );
  }
}
