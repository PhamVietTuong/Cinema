// ignore_for_file: avoid_print

import 'package:cinema_app/constants.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_dropdow.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/room.dart';
import 'package:cinema_app/data/models/seat_type.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:cinema_app/data/models/ticket_option.dart';
import 'package:cinema_app/data/models/ticket_type.dart';
import 'package:cinema_app/presenters/room_presenter.dart';
import 'package:cinema_app/views/4_seat_selection/seat_screen.dart';
import 'package:cinema_app/views/3_ticket_selection/ticket_option.dart';
import 'package:flutter/material.dart';

class TicketOptionScreen extends StatefulWidget {
  const TicketOptionScreen(
      {super.key,
      required this.booking,
      required this.showtime,
      required this.movie});

  final Booking booking;
  final Movie movie;
  final Showtime showtime;

  @override
  State<TicketOptionScreen> createState() => _TicketOptionScreenState();
}

class _TicketOptionScreenState extends State<TicketOptionScreen>
    implements RoomViewContract {
  late RoomPresenter roomPr;
  bool isLoadingData = true;
  late final String date;
  late String time;
  late Showtime selectedShowtime;
  int totalPrice = 0;
  int totalTicket = 0;
  List<TicketOptionItem> options = List.filled(0,
      TicketOptionItem(option: TicketOption(), upDownQuantity: (bool i, ti) {}),
      growable: true);

  void selectShowtime(Showtime showtime) {
    setState(() {
      selectedShowtime = showtime;
      roomPr.fetchRoomById(selectedShowtime.room.id);
      totalTicket = 0;
      totalPrice = 0;
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

  Widget nextScreen() {
    widget.booking.tickets = options.map((e) => e.option).toList();
    return SeatScreen(
      booking: widget.booking,
      showtime: selectedShowtime,
    );
  }

  @override
  void initState() {
    super.initState();

    selectedShowtime = widget.showtime;
    widget.booking.movie = widget.movie;

    roomPr = RoomPresenter(this);
    roomPr.fetchRoomById(selectedShowtime.room.id);
  }

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    var wS = MediaQuery.of(context).size.width;
    var marginLeft = 10.0;
    var marginHorizontalScreen = 15.0;
    return Scaffold(
        appBar: AppBar(
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
            'CHỌN VÉ',
            style: styles.appBarTextStyle,
          ),
        ),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              //phần thông tin cơ bản, thể loại, hình thức chiếu, suất chiếu
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    MovieTypeBox(
                      title: widget.movie.types.join(', '),
                      maxBoxWith: wS * 0.5 - 10,
                      fontSizeCus: 15,
                      padding: 5,
                    ),
                    ShowtimeTypeBox(
                        title: selectedShowtime.projectionForm.toString(),
                        marginLeft: marginLeft,
                        fontSizeCus: 15),
                    AgeRestrictionBox(
                        title: widget.movie.ageRestriction.name,
                        marginLeft: marginLeft,
                        fontSizeCus: 15),
                    ShowtimeDropDown(
                      marginLeft: marginLeft,
                      showtime: selectedShowtime,
                      showtimes: widget.movie.showtimes,
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
                          child: Image(image: AssetImage(widget.movie.img)),
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
                                  '${widget.movie.name} ${selectedShowtime.projectionForm} (${widget.movie.ageRestriction.name})',
                                  style: styles.titleTextStyle,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on,
                                        size: styles.iconSizeInLineText),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          "${widget.booking.theater.name} - Phòng: ${selectedShowtime.room.name}",
                                          style: styles.normalTextStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.av_timer_rounded,
                                      size: styles.iconSizeInLineText),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Suất chiếu: ${selectedShowtime.getFormatTime()} - ${selectedShowtime.getFormatDate()}",
                                        style: styles.normalTextStyle,
                                        softWrap: true,
                                      ),
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
  void onLoadRoomComplete(List<Room> rooms) {
    setState(() {
      selectedShowtime.room =
          rooms.firstWhere((room) => room.id == selectedShowtime.room.id);
      roomPr.fetchTicketOptionsBySeatIds(selectedShowtime.room.seatTypeIds);
    });
  }

  @override
  void onLoadRoomError() {}

  @override
  Future<void> onLoadTicketOptionComplete(
      List<TicketOption> ticketOptions) async {
    List<TicketType> ticketTypes = await TicketType.fetchTicketTypes();
    List<SeatType> seatTypes = await SeatType.fetchSeatTypes();

    for (var option in ticketOptions) {
      option.seatType = seatTypes
          .singleWhere((seatType) => seatType.id == option.seatType.id);
      option.ticketType = ticketTypes
          .singleWhere((ticketType) => ticketType.id == option.ticketType.id);
    }
    setState(() {
      options = ticketOptions
          .map((ticketOption) => TicketOptionItem(
                option: ticketOption,
                upDownQuantity: upDownOptionQuantity,
              ))
          .toList();
    });
  }
}
