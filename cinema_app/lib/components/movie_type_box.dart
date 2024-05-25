import 'package:cinema_app/constants.dart';
import 'package:flutter/material.dart';

class MovieTypeBox extends StatelessWidget {
  const MovieTypeBox(
      {super.key,
      this.fontSizeCus = 0.0,
      this.maxBoxWith = 0.0,
      this.marginBottom = 0.0,
      this.padding = 0.0,
      this.marginTop = 0.0, required this.title});
  final String title;
  final double fontSizeCus;
  final double maxBoxWith;
  final double marginTop;
  final double marginBottom;
  final double padding;

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      constraints: maxBoxWith != 0.0
          ? BoxConstraints(maxWidth: maxBoxWith)
          : const BoxConstraints(),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(3.0),
          color: Colors.blue[100]),
      child: Text(
        title,
        style: fontSizeCus != 0.0
            ? styles.normalTextStyle.copyWith(fontSize: fontSizeCus)
            : styles.normalTextStyle,
      ),
    );
  }
}
