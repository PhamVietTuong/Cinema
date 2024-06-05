import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class MovieTypeBox extends StatelessWidget {
  const MovieTypeBox(
      {super.key,
      this.maxBoxWith = 0.0,
      this.marginBottom = 0.0,
      this.padding = 0.0,
      this.marginTop = 0.0,
      required this.title});
  final String title;
  final double maxBoxWith;
  final double marginTop;
  final double marginBottom;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      constraints: maxBoxWith != 0.0
          ? BoxConstraints(maxWidth: maxBoxWith)
          : const BoxConstraints(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Styles.gradientTop["dark_purple"]!,
                Styles.gradientBot["dark_purple"]!
              ])),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Styles.backgroundContent["dark_purple"]),
        child: Text(
          title,
          style: TextStyle(color: Styles.boldTextColor["dark_purple"]),
        ),
      ),
    );
  }
}
