import 'package:cinema_app/style.dart';
import 'package:flutter/material.dart';

class ShowtimeTypeBox extends StatelessWidget {
  const ShowtimeTypeBox(
      {super.key,
      required this.title,
      this.fontSizeCus = 0.0,
      this.marginLeft = 0.0,
      this.padding = 5.0});
  final String title;
  final double marginLeft;
  final double fontSizeCus;
  final double padding;
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      padding:  EdgeInsets.all(padding),
      margin: EdgeInsets.only(left: marginLeft),
      decoration: BoxDecoration(
        border: styles.borderWith,
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        title,
        style: fontSizeCus != 0.0
            ? styles.titleTextStyle.copyWith(fontSize: fontSizeCus)
            : styles.titleTextStyle,
      ),
    );
  }
}
