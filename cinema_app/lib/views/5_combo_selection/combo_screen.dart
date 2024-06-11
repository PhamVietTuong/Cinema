import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/food_and_drink.dart';
import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/presenters/theater_presenter.dart';
import 'package:cinema_app/views/5_combo_selection/combo_item.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/views/6_payment/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';

class ComboScreen extends StatefulWidget {
  const ComboScreen(
      {super.key,
      required this.booking,
      required this.selectedSeats,
      required this.showtime,
      required this.hub});
  final Booking booking;
  final List<Seat> selectedSeats;
  final ShowtimeRoom showtime;
  final HubConnection hub;

  @override
  State<ComboScreen> createState() => _ComboScreenState();
}

class _ComboScreenState extends State<ComboScreen>
    implements TheaterViewContract {
  late TheaterPresenter theaterPre;
  bool isLoading = true;

  void upDownOptionQuantity(bool isUp, FoodAndDrink item) {
    setState(() {
      var combos = widget.booking.theater.combos;

      int index = combos.indexOf(item);
      isUp
          ? combos[index].quantity++
          : combos[index].quantity == 0
              ? 0
              : combos[index].quantity--;
    });
  }

  @override
  void initState() {
    super.initState();
    theaterPre = TheaterPresenter(this);
    theaterPre.fetchCombos(widget.booking.theater.id);
    widget.booking.tickets.removeWhere((element) => element.quantity == 0);

    widget.booking.seats = widget.selectedSeats;
    widget.booking.showtime = widget.showtime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Styles.backgroundContent["dark_purple"],
        leading: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            widget.booking.theater.combos = [];
            widget.booking.seats = [];
            widget.booking.showtime = ShowtimeRoom();
            Navigator.pop(this.context);
          },
          icon: Icon(Icons.arrow_back_ios_new,
              color: Styles.boldTextColor["dark_purple"]),
        ),
        titleSpacing: 0,
        leadingWidth: 45,
        title: Text(
          "Combo",
          style: TextStyle(
              fontSize: Styles.appbarFontSize,
              fontWeight: FontWeight.bold,
              color: Styles.boldTextColor["dark_purple"]),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(color: Styles.backgroundColor["dark_purple"]),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: widget.booking.theater.combos
                      .map((e) =>
                          ComboItem(item: e, function: upDownOptionQuantity))
                      .toList(),
                ),
              ),
            ),
            //const ComboCart(),
            Container(
                margin: const EdgeInsets.only(bottom: 15),
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
                  nextScreen: PayScreen(
                    booking: widget.booking,
                    hub: widget.hub,
                  ),
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
    _showErrorDialog();
  }

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Lỗi"),
            content: const Text(
                "Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại sau."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Đóng hộp thoại
                  Navigator.of(context).pop();
                },
                child: const Text("Đóng"),
              ),
              TextButton(
                onPressed: () {
                  // Gọi hàm để tải dữ liệu lại
                },
                child: const Text("Tải lại"),
              ),
            ],
          );
        });
  }

  @override
  void onLoadTheaterComplete(List<Theater> theaters) {}
}
