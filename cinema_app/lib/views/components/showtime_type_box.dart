import 'package:cinema_app/style.dart';
import 'package:flutter/material.dart';

class ShowtimeTypeBox extends StatelessWidget {
  const ShowtimeTypeBox(
      {super.key,
      required this.title,
      this.fontSizeCus = 0.0,
      this.marginLeft = 0.0, this.colorText=Colors.black});
  final String title;
  final double marginLeft;
  final double fontSizeCus;
  //nhu y add prop colorText => đổi màu viền + chữ(datetime:4/4 11:43pm)
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(left: marginLeft),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorText),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        title,
        style: fontSizeCus != 0.0
            ? styles.titleTextStyle.copyWith(fontSize: fontSizeCus, color: colorText)
            : styles.titleTextStyle.copyWith(color: colorText),
      ),
    );
  }
}
