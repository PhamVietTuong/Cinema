import 'package:flutter/material.dart';

import '../config.dart';

class TimeBox extends StatefulWidget {
  const TimeBox({super.key, this.marginLeft=0.0, required this.time});
  final int time;
  final double marginLeft;

  @override
  State<TimeBox> createState() => _TimeBoxState();
}

class _TimeBoxState extends State<TimeBox> {
  String minute="phút";
   void translate() async {
    List<String> translatedTexts = await Future.wait([
      Styles.translate(minute),
    ]);
    minute = translatedTexts[0];
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    translate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: widget.marginLeft),
      child: Row(
        children: [
          Icon(
            Icons.timer_outlined,
            color: Styles.boldTextColor[Config.themeMode],
          ),
          Text(
            "${widget.time} $minute",
            style: TextStyle(
                fontSize: Styles.textSize,
                color: Styles.textColor[Config.themeMode]),
          )
        ],
      ),
    );
  }
}
