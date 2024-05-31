import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DayItemBox extends StatelessWidget {
  DayItemBox(
      {super.key,
      required this.date,
      required this.selectDay,
      required this.isSelected});
  var isSelected = false;
  late final String? titleDay;
  final DateTime date;

  final Function(DateTime) selectDay;

  @override
  Widget build(BuildContext context) {
    titleDay = switch (DateFormat("EEEE").format(date)) {
      "Monday" => "Thứ 2",
      "Tuesday" => "Thứ 3",
      "Wednesday" => "Thứ 4",
      "Thursday" => "Thứ 5",
      "Friday" => "Thứ 6",
      "Saturday" => "Thứ 7",
      String() => "CN",
    };
    return GestureDetector(
      onTap: () {
        selectDay(date);
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 6),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: isSelected?null: Styles.btnColor["dark_purple"],
            gradient:isSelected? LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:[
              Styles.gradientTop["dark_purple"]!,
              Styles.gradientBot["dark_purple"]!
            ]):null,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Text(
              titleDay!,
              style:   TextStyle(
                  color: Styles.boldTextColor["dark_purple"],
                  fontWeight: FontWeight.bold, fontSize: Styles.titleFontSize),
            ),
            Text(
              "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}",
              style:TextStyle( fontWeight: FontWeight.bold, fontSize: Styles.titleFontSize,
                  color: !isSelected ? Styles.boldTextColor["dark_purple"] : Styles.textSelectionColor["dark_purple"]),
            )
          ],
        ),
      ),
    );
  }
}
