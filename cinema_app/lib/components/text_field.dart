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
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.info,
      style: TextStyle(color: Styles.boldTextColor["dark_purple"]),
      decoration: InputDecoration(
        labelText: widget.title,
        prefixIcon: widget.icon,
        labelStyle: TextStyle(color: Styles.boldTextColor["dark_purple"]),
        prefixIconColor:Styles.boldTextColor["dark_purple"] ,
        focusColor: Styles.boldTextColor["dark_purple"],
      ),
    );
  }
}
