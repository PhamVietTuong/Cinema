import 'package:cinema_app/style.dart';
import 'package:flutter/material.dart';

class TicketBox extends StatelessWidget {
  const TicketBox({super.key});

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.purple), borderRadius: BorderRadius.circular(5)),
      child:  Column(
        children: [
          Text("E07", style: TextStyle(color: styles.primaryColor),),
          Text("70,000", style: TextStyle(color: styles.primaryColor),),
        ],
      ),
    );
  }
}
