import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/views/4_seat_selection/seat_box.dart';
import 'package:flutter/material.dart';

class SeatRow extends StatelessWidget {
  const SeatRow(
      {super.key,
      required this.seats,
      required this.name,
      required this.selelctSeat});
  final List<Seat> seats;
  final String name;
  final bool Function(int id, bool state) selelctSeat;
  @override
  Widget build(BuildContext context) {
    List<SeatBox> seatBoxs = List.filled(
        0,
        SeatBox(
          index: 0,
          name: "",
          seat: Seat(),
          selectSeat: (id, a) {
            return true;
          },
        ),
        growable: true);
    int index = 0;
    seats.sort(
      (a, b) => a.colIndex.compareTo(b.colIndex),
    );
    for (Seat seat in seats) {
      if (seat.isSeat == 1) {
        index++;
      }
      seatBoxs.add(SeatBox(
        seat: seat,
        name: name,
        index: seat.isSeat == 0 ? 0 : index,
        selectSeat: selelctSeat,
      ));
    }
    return Expanded(
      child: Row(
        children: seatBoxs,
      ),
    );
  }
}
