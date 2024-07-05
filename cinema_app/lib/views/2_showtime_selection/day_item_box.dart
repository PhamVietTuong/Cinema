import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DayItemBox extends StatefulWidget {
  DayItemBox(
      {super.key,
      required this.date,
      required this.selectDay,
      required this.isSelected});
  var isSelected = false;
  final DateTime date;

  final Function(DateTime) selectDay;

  @override
  State<DayItemBox> createState() => _DayItemBoxState();
}

class _DayItemBoxState extends State<DayItemBox> {
  late String titleDay;
  final DateTime today = DateTime.now();
  String textToday = "Hôm nay";
  void translate() async {
    List<String> translatedTexts = await Future.wait([
      Styles.translate(textToday),
      Styles.translate(titleDay),
    ]);
    textToday = translatedTexts[0];
    titleDay = translatedTexts[1];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    titleDay = DateFormat("EEEE").format(widget.date);
    translate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectDay(widget.date);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        margin: const EdgeInsets.only(right: 8, bottom: 5),
        constraints: BoxConstraints(minWidth: 80),
        decoration: BoxDecoration(
          color: widget.isSelected ? null : Styles.btnColor[Config.themeMode],
          gradient: widget.isSelected
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                      Styles.gradientTop[Config.themeMode]!,
                      Styles.gradientBot[Config.themeMode]!
                    ])
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          boxShadow: const [
            BoxShadow(
              offset:
                  Offset(0, 3), // offset đổ bóng theo trục X và Y (phía dưới)
              color: Color.fromARGB(
                  80, 0, 0, 1), // màu của đổ bóng với độ trong suốt thấp
              blurRadius: 3, // bán kính làm mờ
              spreadRadius: 0, // bán kính lan rộng
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              widget.date.day == today.day ? textToday : titleDay,
              style: TextStyle(
                  color: Styles.boldTextColor[Config.themeMode],
                  fontWeight: FontWeight.bold,
                  fontSize: Styles.titleFontSize),
            ),
            Text(
              "${widget.date.day.toString().padLeft(2, '0')}/${widget.date.month.toString().padLeft(2, '0')}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Styles.titleFontSize,
                  color: !widget.isSelected
                      ? Styles.boldTextColor[Config.themeMode]
                      : Styles.textSelectionColor[Config.themeMode]),
            )
          ],
        ),
      ),
    );
  }
}
