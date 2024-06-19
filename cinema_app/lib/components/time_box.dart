import 'package:flutter/material.dart';

import '../config.dart';

class TimeBox extends StatelessWidget {
  const TimeBox({super.key, this.marginLeft=0.0, required this.time});
  final int time;
  final double marginLeft;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      child: Row(
        children: [
          Icon(
            Icons.timer_outlined,
            color: Styles.boldTextColor[Config.themeMode],
          ),
          Text(
            "$time phút",
            style: TextStyle(
                fontSize: Styles.textSize,
                color: Styles.textColor[Config.themeMode]),
          )
        ],
      ),
    );
  }
}
