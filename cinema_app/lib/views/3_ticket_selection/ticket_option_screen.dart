// ignore_for_file: avoid_print

import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_dropdow.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/ticket_option.dart';
import 'package:cinema_app/data/models/tickets.dart';
import 'package:cinema_app/presenters/ticket_presenter.dart';
import 'package:cinema_app/views/4_seat_selection/seat_screen.dart';
import 'package:cinema_app/views/3_ticket_selection/ticket_option.dart';
import 'package:flutter/material.dart';

import '../../data/models/showtime.dart';

class TicketOptionScreen extends StatefulWidget {
  const TicketOptionScreen(
      {super.key,
      required this.booking,
      required this.showtimeRoom,
      required this.movie,
      required this.selectedDate});

  final Booking booking;
  final Movie movie;
  final ShowtimeRoom showtimeRoom;
  final DateTime selectedDate;

  @override
  State<TicketOptionScreen> createState() => _TicketOptionScreenState();
}

class _TicketOptionScreenState extends State<TicketOptionScreen>
    implements TicketViewContract {
  late TicketPresenter ticketPre;

  bool isLoadingData = true;
  late ShowtimeRoom selectedShowtime;

  int totalPrice = 0;
  int totalTicket = 0;

  List<TicketOptionItem> options = List.filled(0,
      TicketOptionItem(option: TicketOption(), upDownQuantity: (bool i, ti) {}),
      growable: true);

  void selectShowtime(ShowtimeRoom showtime) {
    setState(() {
      selectedShowtime = showtime;
      totalTicket = 0;
      totalPrice = 0;
      ticketPre.fetchTicketOptions(
          selectedShowtime.showTimeId, selectedShowtime.roomId);
    });
  }

  void upDownOptionQuantity(bool isUp, TicketOptionItem item) {
    setState(() {
      int index = options.indexOf(item);
      isUp
          ? options[index].option.quantity++
          : options[index].option.quantity == 0
              ? 0
              : options[index].option.quantity--;

      totalTicket = 0;
      totalPrice = 0;
      for (var item in options) {
        totalPrice = totalPrice + item.option.price * item.option.quantity;
        totalTicket += item.option.quantity;
      }
    });
  }

  bool handle() {
    if (totalTicket == 0 && widget.booking.getTotalTickets() == 0) {
      print("stop");
      return false;
    }
    return true;
  }

  Widget nextScreen() {
    widget.booking.tickets = options.map((e) => e.option).toList();
    return SeatScreen(
      booking: widget.booking,
      showtime: selectedShowtime,
      selectedDate: widget.selectedDate,
    );
  }

  @override
  void initState() {
    super.initState();
    ticketPre = TicketPresenter(this);

    selectedShowtime = widget.showtimeRoom;
    widget.booking.movie = widget.movie;

    ticketPre.fetchTicketOptions(
        selectedShowtime.showTimeId, selectedShowtime.roomId);
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var marginLeft = 10.0;
    var marginHorizontalScreen = 15.0;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.backgroundContent["dark_purple"],
          leading: IconButton(
            alignment: Alignment.center,
            onPressed: () {
              Navigator.pop(this.context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Styles.boldTextColor["dark_purple"],
            ),
          ),
          titleSpacing: 0,
          leadingWidth: 45,
          title: Text(
            'CHỌN VÉ',
            style: TextStyle(
                fontSize: Styles.appbarFontSize,
                color: Styles.boldTextColor["dark_purple"]),
          ),
        ),
        body: Center(
          child: Container(
            decoration:
                BoxDecoration(color: Styles.backgroundColor["dark_purple"]),
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              //phần thông tin cơ bản, thể loại, hình thức chiếu, suất chiếu
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    MovieTypeBox(
                      title: widget.movie.movieType,
                      maxBoxWith: wS * 0.5 - 10,
                      padding: 5,
                    ),
                    ShowtimeTypeBox(
                      title: widget.movie.showTimeTypeName,
                      marginLeft: marginLeft,
                    ),
                    AgeRestrictionBox(
                        title: widget.movie.ageRestrictionName,
                        marginLeft: marginLeft,
                        fontSizeCus: 15),
                    ShowtimeDropDown(
                      marginLeft: marginLeft,
                      showtime: selectedShowtime,
                      showtimes: widget.movie.schedules
                          .firstWhere((element) =>
                              element.date.day == widget.selectedDate.day &&
                              element.date.month == widget.selectedDate.month)
                          .theaters
                          .firstWhere(
                              (element) =>
                                  element.theaterId ==
                                  widget.booking.theater.id,
                              orElse: () => TheaterShowtime())
                          .showtimes,
                      selectShowtime: selectShowtime,
                    )
                  ],
                ),
              ),
              //thông tin phim, rạp, phòng, ngày giờ
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: wS * 0.13,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image(
                              image: widget.movie.img.isEmpty
                                  ? const AssetImage(
                                          "assets/img/movie_white.png")
                                      as ImageProvider
                                  : NetworkImage(
                                      "$serverUrl/Images/${widget.movie.img}")),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                    '${widget.movie.name} ${widget.movie.showTimeTypeName} (${widget.movie.ageRestrictionName})',
                                    style: TextStyle(
                                        color:
                                            Styles.boldTextColor["dark_purple"],
                                        fontSize: Styles.titleFontSize,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: Styles.iconSizeInLineText,
                                      color:
                                          Styles.boldTextColor["dark_purple"],
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Text(
                                            "${widget.booking.theater.name} - Phòng: ${selectedShowtime.roomName}",
                                            style: TextStyle(
                                              color: Styles
                                                  .textColor["dark_purple"],
                                              fontSize: Styles.textSize,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.av_timer_rounded,
                                    size: Styles.iconSizeInLineText,
                                    color: Styles.boldTextColor["dark_purple"],
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Text(
                                          "Suất chiếu: ${selectedShowtime.getFormatTime()} - ${selectedShowtime.getFormatDate()}",
                                          softWrap: true,
                                          style: TextStyle(
                                            color:
                                                Styles.textColor["dark_purple"],
                                            fontSize: Styles.textSize,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              //chọn loại ghế
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                  child: SingleChildScrollView(
                    child: Column(children: options),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 25, left: 8, right: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: const Offset(1, 1))
                      ]),
                  child: BookingSummaryBox(
                    handle: handle,
                    nextScreen: nextScreen(),
                    booking: widget.booking,
                    totalPrice: totalPrice,
                    totalTicket: totalTicket,
                  ))
            ]),
          ),
        ));
  }

  @override
  void onLoadTicketComplete(List<Ticket> tickets) {}

  @override
  void onLoadTicketError() {}

  @override
  void onLoadTicketOptionComplete(List<TicketOption> ticketOptions) {
    setState(() {
      ticketOptions.sort((a, b) => a.price.compareTo(b.price));
      options = ticketOptions
          .map((e) =>
              TicketOptionItem(option: e, upDownQuantity: upDownOptionQuantity))
          .toList();
    });
  }
}
