// ignore_for_file: avoid_print

import 'package:cinema_app/components/time_box.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/info_bar.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/components/title_bar.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/data/models/ticket_option.dart';
import 'package:cinema_app/views/6_payment/payment_options.dart';
import 'package:cinema_app/views/6_payment/ticket_box.dart';
import 'package:cinema_app/views/7_ticket_info/ticket_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key, required this.booking, required this.hub});
  final Booking booking;
  final HubConnection hub;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  int discount = 0;
  List<TicketBox> tBoxs = List.filled(
      0,
      const TicketBox(
        name: "",
        price: 0,
        ticketTypeId: "",
        seatId: "",
      ),
      growable: true);
  final List<PaymentOption> paymentOptions = [
    const PaymentOption(
      title: 'Visa, Master, JCB, AMEX, CUP',
      img: "assets/img_demo/visa_masterCard_logo.png",
    ),
    const PaymentOption(
      title: 'Ví Momo',
      img: "assets/img_demo/momo_logo.png",
    ),
    const PaymentOption(
      title: 'VNPay',
      img: "assets/img_demo/vnpay_logo.png",
    ),
  ];
  PaymentOption? selectedOption;

  void loadTicketBoxs() {
    tBoxs.clear();
    if (widget.booking.countingSignle() > 0) {
      List<Seat> seatSingle = widget.booking.seats
          .where((element) => element.seatTypeName.compareTo("Đơn") == 0)
          .toList();
      List<TicketOption> typeSingle = widget.booking.tickets
          .where((element) => element.seatTypeName.compareTo("Đơn") == 0)
          .toList();
      var index = 0;
      for (var type in typeSingle) {
        var count = type.quantity;
        while (count > 0) {
          tBoxs.add(TicketBox(
            seatId: seatSingle[index].id,
            name: seatSingle[index].name,
            price: type.price,
            ticketTypeId: type.ticketTypeId,
          ));
          count--;
          index++;
        }
      }
    }

    if (widget.booking.countingCouple() > 0) {
      List<Seat> seatCouple = widget.booking.seats
          .where((element) => element.seatTypeName.compareTo("Ðôi") == 0)
          .toList();
      List<TicketOption> typeCouple = widget.booking.tickets
          .where((element) => element.seatTypeName.compareTo("Ðôi") == 0)
          .toList();

      var index = 0;

      for (var type in typeCouple) {
        var count = type.quantity;
        while (count > 0) {
          tBoxs.add(TicketBox(
            seatId: seatCouple[index].id,
            name: seatCouple[index].name,
            price: type.price,
            ticketTypeId: type.ticketTypeId,
          ));
          count--;
          index++;
        }
      }
    }
  }

  List<InfoBar> loadCombosInfo() {
    return widget.booking.theater.combos
        .where((element) => element.quantity > 0)
        .map((e) => InfoBar(
              img: e.image,
              title: e.name,
              value: e.quantity.toString(),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loadTicketBoxs();
    });
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Styles.backgroundContent["dark_purple"],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.booking.theater.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Styles.boldTextColor["dark_purple"],
                        fontSize: Styles.titleFontSize),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    '${widget.booking.showtime.getFormatDate()} - ${widget.booking.showtime.getFormatTime()} | Phòng: ${widget.booking.showtime.roomName}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Styles.boldTextColor["dark_purple"],
                        fontSize: Styles.titleFontSize),
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(right: 15),
                child: const Text(
                  "04:55",
                ))
          ],
        ),
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Container(
            decoration:
                BoxDecoration(color: Styles.backgroundColor["dark_purple"]),
            child: Column(children: [
              //thông tin phim
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //poster
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: (wS - 30) * 0.25,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                                image: widget.booking.movie.img.isEmpty
                                    ? const AssetImage(
                                            'assets/img/movie_white.png')
                                        as ImageProvider
                                    : NetworkImage(
                                        '$serverUrl/Images/${widget.booking.movie.img}')))),
                    //thông tin chi tiết về phim và ghế đã chọn
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.booking.movie.getFullName(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Styles.titleFontSize,
                                color: Styles.boldTextColor["dark_purple"]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //thể loại, giới hạn tuổi, kiểu xuất chiếu
                          MovieTypeBox(
                            title: widget.booking.movie.movieType,
                            padding: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              ShowtimeTypeBox(
                                title: widget.booking.movie.showTimeTypeName,
                                padding: 5,
                              ),
                              AgeRestrictionBox(
                                title: widget.booking.movie.ageRestrictionName,
                                marginLeft: 15,
                                padding: 5,
                              ),
                              TimeBox(
                                time: widget.booking.movie.time,
                                marginLeft: 10,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                              text: TextSpan(
                                  children: [
                                const TextSpan(text: "Ghế: "),
                                TextSpan(
                                    text: widget.booking.seats
                                        .map((e) => e.name)
                                        .join(", "))
                              ],
                                  style: TextStyle(
                                      fontSize: Styles.titleFontSize,
                                      color:
                                          Styles.boldTextColor["dark_purple"])))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //thông tin vé
              const TitleBar(title: "THÔNG TIN VÉ"),
              Container(
                width: wS,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: tBoxs,
                  ),
                ),
              ),
              InfoBar(title: "SỐ LƯỢNG", value: '${tBoxs.length}'),
              InfoBar(
                  title: "Tổng",
                  value: Styles.formatter
                      .format(widget.booking.getPriceTickets())),
              //thông bắp nước
              widget.booking.theater.combos
                      .any((element) => element.quantity > 0)
                  ? Column(
                      children: [
                        const TitleBar(title: "THÔNG TIN BẮP NƯỚC"),
                        Column(
                          children: loadCombosInfo(),
                        ),
                        InfoBar(
                            title: "Tổng",
                            value: Styles.formatter
                                .format(widget.booking.getPriceCombos())),
                      ],
                    )
                  : const SizedBox(),

              //nhập khuyến mãi
              Container(
                decoration: BoxDecoration(
                    color: Styles.backgroundContent["dark_purple"]),
                width: wS,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Styles.gradientTop["dark_purple"]!,
                              Styles.gradientBot["dark_purple"]!,
                            ]),
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Styles.backgroundContent["dark_purple"],
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            style: TextStyle(
                                fontSize: Styles.titleFontSize,
                                color: Styles.boldTextColor["dark_purple"]),
                            decoration: InputDecoration(
                                hintText: "Mã khuyến mãi",
                                hintStyle: TextStyle(
                                    color: Styles.boldTextColor["dark_purple"]),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.redeem_outlined,
                                    color:
                                        Styles.boldTextColor["dark_purple"])),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Áp dụng");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Styles.btnColor["dark_purple"]),
                        child: const Text(
                          "ÁP DỤNG",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const TitleBar(title: "Thanh Toán"),
              InfoBar(
                title: "Tổng cộng:",
                value: Styles.formatter.format(widget.booking.getTotalPrice()),
              ),
              InfoBar(
                title: "Giảm giá:",
                value: Styles.formatter.format(discount),
              ),
              InfoBar(
                title: "Còn lại:",
                value: Styles.formatter
                    .format(widget.booking.getTotalPrice() - discount),
              ),
              Column(
                children: paymentOptions
                    .map((option) => RadioListTile<PaymentOption>(
                          dense: true,
                          value: option,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: option,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value!;
                            });
                          },
                        ))
                    .toList(),
              ),

              GestureDetector(
                onTap: () async {
                  print("Thanh Toán");
                  await widget.hub.invoke("CheckTheSeatBeforeBooking", args: [
                    {
                      "showTimeId": widget.booking.showtime.showTimeId,
                      "roomId": widget.booking.showtime.roomId,
                      "theaterId": widget.booking.theater.id,
                      "userId": '5f24b03d-1cbd-4141-017d-08dc73cfa571',
                      "invoiceTickets": tBoxs
                          .map((e) => {
                                "SeatId": e.seatId,
                                "TicketTypeId": e.ticketTypeId
                              })
                          .toList(),
                      "foodAndDrinks": widget.booking.theater.combos
                          .where((element) => element.quantity > 0)
                          .map((e) =>
                              {"FoodAndDrinkId": e.id, "Quantity": e.quantity})
                          .toList()
                    }
                  ]).then((value) {
                    if (value != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketInfoScreen(
                              result: value,
                              booking: widget.booking,
                            ),
                          ));
                    }
                  });
                  ;
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: Styles.btnColor["dark_purple"],
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "THANH TOÁN",
                    style: TextStyle(
                        color: Styles.boldTextColor["dark_purple"],
                        fontWeight: FontWeight.bold,
                        fontSize: Styles.titleFontSize),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
