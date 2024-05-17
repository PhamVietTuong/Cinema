import 'package:cinema_app/constants.dart';
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
    var styles = Styles();
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
            color: isSelected ? Colors.yellow : styles.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Text(
              titleDay!,
              style: styles.titleTextStyle.copyWith(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}",
              style: styles.titleTextStyle.copyWith(
                  color: isSelected ? Colors.black : Colors.yellow[400]),
            )
          ],
        ),
      ),
    );
  }
}
