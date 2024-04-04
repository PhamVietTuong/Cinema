import 'package:cinema_app/style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DayItemBox extends StatefulWidget {
   DayItemBox({super.key});
  var isSelected = false;
  @override
  State<DayItemBox> createState() => _DayItemBoxState();
}

class _DayItemBoxState extends State<DayItemBox> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return GestureDetector(
      onTap: () => setState(() {
        widget.isSelected=!widget.isSelected;
      }),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 6),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: widget.isSelected ? Colors.yellow : styles.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Text(
              "Hôm nay",
              style: styles.titleTextStyle.copyWith(
                  color: widget.isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "04/04",
              style: styles.titleTextStyle.copyWith(
                  color: widget.isSelected ? Colors.black : Colors.yellow[400]),
            )
          ],
        ),
      ),
    );
  }
}
