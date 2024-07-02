import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class ShowtimeTypeBox extends StatelessWidget {
  const ShowtimeTypeBox(
      {super.key,
      required this.title,
      this.marginLeft = 0.0,
      this.padding = 5.0});
  final String title;
  final double marginLeft;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding:  EdgeInsets.all(padding),
      margin: EdgeInsets.only(left: marginLeft),
      decoration: BoxDecoration(
       border: Border.all(width: 1,color: Styles.boldTextColor[Config.themeMode]!),
        color: Styles.boldTextColor[Config.themeMode],
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        title,
        style:  TextStyle(
            color: Styles.textBoldSelectionColor[Config.themeMode],
            fontSize: Styles.textSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
