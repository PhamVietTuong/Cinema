import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/food_and_drink.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/presenters/theater_presenter.dart';
import 'package:cinema_app/views/5_combo_selection/combo_item.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/views/6_payment/pay_screen.dart';
import 'package:flutter/material.dart';

class ComboScreen extends StatefulWidget {
  const ComboScreen(
      {super.key,
      required this.booking,
      required this.selectedSeatIds,
      required this.showtime});
  final Booking booking;
  final List<String> selectedSeatIds;
  final ShowtimeRoom showtime;

  @override
  State<ComboScreen> createState() => _ComboScreenState();
}

class _ComboScreenState extends State<ComboScreen>
    implements TheaterViewContract {
  late TheaterPresenter theaterPre;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    theaterPre = TheaterPresenter(this);
    theaterPre.fetchCombos(widget.booking.theater.id);
    widget.booking.seatIds = widget.selectedSeatIds;
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          "Combo",
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(),
        child: Column(
          children: [
             Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Column(
                  children: widget.booking.theater.combos.map((e) => ComboItem(item: e)).toList(),
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

  @override
  void onLoadCombosByTheater(List<FoodAndDrink> combos) {
    setState(() {
      widget.booking.theater.combos = combos;
      isLoading = false;
    });
  }

  @override
  void onLoadError() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoadTheaterComplete(List<Theater> theaters) {}
}
