import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    return Container(
      width: wS,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: const BoxDecoration(color: Color(0xFF9E9E9E)),
      child:  Text(
        title,
        style: const TextStyle(fontSize: 20, color: Color(0xFF65328F)),
      ),
    );
  }
}
