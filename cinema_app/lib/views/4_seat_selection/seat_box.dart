// ignore_for_file: avoid_print

import 'package:cinema_app/constants.dart';
import 'package:cinema_app/data/models/seat.dart';
import 'package:flutter/material.dart';

class SeatBox extends StatefulWidget {
  const SeatBox(
      {super.key,
      required this.seat,
      required this.name,
      required this.index,
      required this.selectSeat});

  final Seat seat;
  final String name;
  final int index;
  final bool Function(int id, bool state) selectSeat;

  @override
  State<SeatBox> createState() => _SeatBoxState();
}

class _SeatBoxState extends State<SeatBox> {
  var styles = Styles();
  bool isSelected = false;
  int loadSeatColor() {
    //trạng thái đã bán
    if (widget.seat.status == 0) {
      return 3;
    }

    //trạng thái trống
    if (widget.seat.status == 1) {
      return widget.seat.seatTypeId;
    }
    // trạng thái đang chọn
    if (widget.seat.status == 2) {
      return 4;
    }

    // trạng thái đang chờ stt=3
    return 5;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String seatName =
        '${widget.name}${widget.index.toString().padLeft(2, '0')}';
    Map<int, Color> colorMap = {
      1: styles.singleSeatColor,
      2: styles.coupleSeatColor,
      3: styles.soldColor,
      4: styles.selectedSeatColor,
      5: styles.waitingSeatColor
    };
    //int rowIndex = widget.seat.rowIndex;
    //print('id: ${widget.seat.id } - stt: ${widget.seat.status}');
    return GestureDetector(
      onTap: () {
        int stt = widget.seat.status;
        if (stt == 0 || stt == 3) {
          return;
        }
        widget.selectSeat(widget.seat.id, isSelected)
            ? setState(() {
                if (!isSelected) {
                  widget.seat.status = 2;
                  isSelected = !isSelected;
                } else {
                  widget.seat.status = 1;
                  isSelected = !isSelected;
                }
              })
            : 1;
      },
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: widget.seat.seatTypeId == 1 ? 1 : 2,
              child: widget.seat.isSeat != 0
                  ? Container(
                      margin: const EdgeInsets.only(right: 3, bottom: 3),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: colorMap[loadSeatColor()]!)),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(1.5),
                        decoration:
                            BoxDecoration(color: colorMap[loadSeatColor()]!),
                        child: Text(
                          seatName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
