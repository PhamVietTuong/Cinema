import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';
// Đảm bảo import đúng

// ignore: must_be_immutable
class InfoTextField extends StatefulWidget {
  InfoTextField(
      {Key? key, required this.info, required this.icon, required this.title})
      : super(key: key);
  TextEditingController info = TextEditingController();
  String title;
  final Icon icon;

  @override
  State<InfoTextField> createState() => _InfoTextFieldState();
}

class _InfoTextFieldState extends State<InfoTextField> {
 late String textTitle;
 void tranlate() async{
  List<String> textTranlate = await Future.wait([
    Styles.translate(textTitle),

  ]
  );
  textTitle=textTranlate[0];
  setState(() {
    
  });
 }
 @override
  void initState() {
    super.initState();
    textTitle=widget.title;
    tranlate();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.info,
      style: TextStyle(color:Styles.boldTextColor[Config.themeMode]),
      decoration: InputDecoration(
        labelText: textTitle,
        prefixIcon: widget.icon,
        labelStyle: TextStyle(color:Styles.boldTextColor[Config.themeMode]),
        prefixIconColor:Styles.boldTextColor[Config.themeMode] ,
        focusColor:Styles.boldTextColor[Config.themeMode],
      ),
    );
  }
}
