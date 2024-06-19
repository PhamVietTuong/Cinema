import 'package:cinema_app/config.dart';
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
      decoration:  BoxDecoration(color: Styles.backgroundContent[Config.themeMode]),
      child:  Center(
        child: Text(
          title.toUpperCase(),
          style:  TextStyle(fontSize: 20, color: Styles.titleColor[Config.themeMode]),
        ),
      ),
    );
  }
}
