import 'package:cinema_app/views/4_seat_selection/seat_box.dart';
import 'package:flutter/material.dart';

class SeatRow extends StatelessWidget {
  const SeatRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        children: [
          SeatBox(),
          SeatBox(),
          SeatBox(),
          SeatBox(),
          SeatBox(),
          SeatBox(),
       
        ],
      ),
    );
  }
}
