import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  const InfoBar(
      {super.key,
      required this.title,
      this.value = "",
      this.img = "",
      this.titleMinWith = 0.0,
      this.botBorderW = 2.0});
  final String title;
  final String value;
  final String img;
  final double titleMinWith;
  final double botBorderW;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.only(bottom: botBorderW),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [
              Styles.gradientTop["dark_purple"]!,
              Styles.gradientBot["dark_purple"]!,
            ]),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: Styles.backgroundColor["dark_purple"]),
        child: Row(
          mainAxisAlignment: (titleMinWith != 0.0)
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                img != ""
                    ? Container(
                        margin: const EdgeInsets.only(right: 5),
                        width: 30,
                        child: Image(
                            image: NetworkImage('$serverUrl/Images/$img')))
                    : const SizedBox(),
                Container(
                  constraints: BoxConstraints(minWidth: titleMinWith),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: Styles.titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Styles.boldTextColor["dark_purple"]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: (titleMinWith != 0.0) ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                        fontSize: Styles.titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Styles.boldTextColor["dark_purple"]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
