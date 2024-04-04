import 'package:cinema_app/style.dart';
import 'package:flutter/material.dart';

class AgeRestrictionBox extends StatelessWidget {
  const AgeRestrictionBox(
      {super.key,
      required this.title,
      this.marginLeft = 0.0,
      this.fontSizeCus = 0.0});
  final String title;
  final double marginLeft;
  final double fontSizeCus;
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        color: Colors.amber,
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
