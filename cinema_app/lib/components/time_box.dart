import 'package:flutter/material.dart';

import '../config.dart';

class TimeBox extends StatelessWidget {
  const TimeBox({super.key, required this.time});
  final int time;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer_outlined,
          color: Styles.boldTextColor["dark_purple"],
        ),
        Text(
          "$time phút",
          style: TextStyle(
              fontSize: Styles.textSize,
              color: Styles.textColor["dark_purple"]),
        )
      ],
    );
  }
}
