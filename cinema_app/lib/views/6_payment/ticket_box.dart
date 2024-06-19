import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class TicketBox extends StatelessWidget {
  const TicketBox({
    super.key,
    required this.name,
    required this.price,
    required this.ticketTypeId,
    required this.col, required this.rowName
  });
  final String name;
  final int price;
  final String ticketTypeId;
  final int col;
  final String rowName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Styles.gradientTop[Config.themeMode]!,
            Styles.gradientBot[Config.themeMode]!,
          ])),
      child: Container(
        constraints: const BoxConstraints(minWidth: 55),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        decoration: BoxDecoration(
            color: Styles.backgroundContent[Config.themeMode],
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                  color: Styles.boldTextColor[Config.themeMode],
                  fontSize: Styles.textSize),
            ),

            Text(
              Styles.formatter.format(price),
              style: TextStyle(
                  color: Styles.boldTextColor[Config.themeMode],
                  fontSize: Styles.textSize),
            ),
          ],
        ),
      ),
    );
  }
}
