import 'package:flutter/material.dart';

class ChairTypeColorBox extends StatelessWidget {
  const ChairTypeColorBox({super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50)
        ),
      ), Text(title,style: TextStyle(color: color),)],
    );
  }
}
