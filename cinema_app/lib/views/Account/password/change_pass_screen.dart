import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class ChangePassWordScreen extends StatefulWidget {
  const ChangePassWordScreen({super.key});

  @override
  State<ChangePassWordScreen> createState() => _ChangePassWordScreenState();
}

class _ChangePassWordScreenState extends State<ChangePassWordScreen> {
  String textTitle = "Đổi mật khẩu";

  Future<void> translate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textTitle),
    ]);
    textTitle = textTranlate[0];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    translate();
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
              child: Column(
                children: [],
              ),
            ),
          ),
        ));
  }
}
