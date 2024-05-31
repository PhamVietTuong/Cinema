import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:cinema_app/views/5_combo_selection/combo_title.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/views/6_payment/pay_screen.dart';
import 'package:flutter/material.dart';

class ComboScreen extends StatefulWidget {
  const ComboScreen(
      {super.key, required this.booking, required this.selectedSeatIds, required this.showtime});
  final Booking booking;
  final List<String> selectedSeatIds;
  final ShowtimeRoom showtime;

  @override
  State<ComboScreen> createState() => _ComboScreenState();
}

class _ComboScreenState extends State<ComboScreen> {
  @override
  void initState() {
    super.initState();
    widget.booking.seatIds = widget.selectedSeatIds;
  }

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            Navigator.pop(this.context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        titleSpacing: 0,
        leadingWidth: 45,
        title: Text(
          "Combo",
          style: styles.appBarTextStyle,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ComboTitle(),
                    ComboTitle(),
                  ],
                ),
              ),
            ),
            //const ComboCart(),
            Container(
                margin: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(1, 1))
                    ]),
                child: BookingSummaryBox(
                  handle: () {
                    return true;
                  },
                  nextScreen: PayScreen(booking: widget.booking),
                  booking: widget.booking,
                ))
          ],
        ),
      ),
    );
  }
}
