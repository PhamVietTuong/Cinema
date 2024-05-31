import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class ChairTypeColorBox extends StatelessWidget {
  const ChairTypeColorBox({super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    var styles=Styles();
    return Row(
      children: [Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50)
        ),
      ), Text(title, style: styles.normalTextStyle,)],
    );
  }
}
