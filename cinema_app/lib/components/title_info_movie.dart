import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TitleInfoMovie extends StatelessWidget {
  TitleInfoMovie({super.key, required this.title});
  // ignore: prefer_typing_uninitialized_variables
  var title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 4 - 5,
        child: Text(
          title,
          style:  TextStyle(
            fontSize: Styles.textSize,
            fontWeight: FontWeight.w500,
            color: Styles.titleColor[Config.themeMode],
          ),
        ));
  }
}
