// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cinema_app/components/bottom_nav.dart';
import 'package:cinema_app/components/info_bar.dart';
import 'package:cinema_app/components/qr_box.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/payment_request.dart';
import 'package:cinema_app/presenters/payment_presenter.dart';
import 'package:cinema_app/views/7_ticket_info/payment_web_page.dart';
import 'package:flutter/material.dart';

import '../../components/count_down.dart';
//import 'package:url_launcher/url_launcher.dart';

class TicketInfoScreen extends StatefulWidget {
  const TicketInfoScreen(
      {super.key,
      required this.opt,
      required this.orderId,
      required this.amount,
      required this.booking,
      required this.info});
  final String orderId;
  final int amount;
  final Booking booking;
  final String opt;
  final String info;
  @override
  State<TicketInfoScreen> createState() => _TicketInfoScreenState();
}

class _TicketInfoScreenState extends State<TicketInfoScreen>
    implements PaymentViewContract {
  late final DateTime today;
  late int orderState;
  late PaymentPresenter payPre;

  void reload(int state) {
    setState(() {
      orderState = state;
    });
  }

  Stream<int> get countStream async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield CountDown.time;
    }
  }

  int counter = 0;
  late StreamSubscription<int> subscription;
  @override
  void initState() {
    super.initState();
    CountDown.index = 4;
    subscription = countStream.listen((count) {
      setState(() {});
      if (CountDown.time == 0 && CountDown.index == 4) {
        Navigator.of(context).popUntil((route) {
          return counter++ >= 4 || !Navigator.of(context).canPop();
        });
      }
    });
    orderState = 0;
    today = DateTime.now();
    payPre = PaymentPresenter(this);
    payPre.createPayment(
        PaymentRequest(widget.orderId, widget.amount, widget.info, widget.opt));
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    CountDown.index--;
  }

  String loadState() {
    if (orderState == 0) {
      return "Đang thanh toán";
    }
    if (orderState == 1) {
      return "Thanh toán thành công";
    }
    return "Thanh toán thất bại";
  }

  @override
  Widget build(BuildContext context) {
    var sW = MediaQuery.of(context).size.width;
    var bW = 1.0;
    return Scaffold(
      backgroundColor: Styles.backgroundColor[Config.themeMode],
      appBar: AppBar(
        backgroundColor: Styles.backgroundContent[Config.themeMode],
        title: Text(
          "THÔNG TIN GIAO DỊCH",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Styles.appbarFontSize,
              color: Styles.boldTextColor[Config.themeMode]),
        ),
        leading: const SizedBox(),
        centerTitle: true,
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          // Return false to disable back button
          print("no back");
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNav(),
              ));
          return false;
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Styles.backgroundColor[Config.themeMode]),
              child: Column(children: [
                InfoBar(
                  title: "Người đặt",
                  value: "Nguyễn Ngọc Như Ý",
                  titleMinWith: sW * 0.21,
                  botBorderW: bW,
                ),
                InfoBar(
                  title: "Thời gian",
                  value: Styles.formatDateTime(today),
                  botBorderW: bW,
                  titleMinWith: sW * 0.21,
                ),
                InfoBar(
                  title: "Phim",
                  value: widget.booking.movie.getFullName(),
                  botBorderW: bW,
                  titleMinWith: sW * 0.21,
                ),
                InfoBar(
                  title: "Ghế",
                  value: widget.booking.seats.map((e) => e.name).join(", "),
                  botBorderW: bW,
                  titleMinWith: sW * 0.21,
                ),
                InfoBar(
                  title: "Suất chiếu",
                  value:
                      "${widget.booking.showtime.getFormatTime()} - ${widget.booking.showtime.getFormatDate()}",
                  botBorderW: bW,
                  titleMinWith: sW * 0.21,
                ),
                InfoBar(
                  title: "Rạp",
                  value:
                      "${widget.booking.theater.name} - ${widget.booking.theater.address}",
                  botBorderW: bW,
                  titleMinWith: sW * 0.21,
                ),
                InfoBar(
                  title: "Tổng cộng",
                  value: Styles.formatter.format(widget.amount),
                  botBorderW: 0.5,
                  titleMinWith: sW * 0.21,
                ),
                InfoBar(
                  title: "Trạng thái",
                  value: loadState(),
                  botBorderW: bW,
                  titleMinWith: sW * 0.21,
                ),
                //Qr code mã vé
                if (orderState == 1)
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Mã vé",
                          style: TextStyle(
                              color: Styles.titleColor[Config.themeMode],
                              fontWeight: FontWeight.bold,
                              fontSize: Styles.titleFontSize),
                        ),
                        Text(widget.orderId.toString(),
                            style: TextStyle(
                                color: Styles.boldTextColor[Config.themeMode],
                                fontWeight: FontWeight.bold,
                                fontSize: Styles.titleFontSize)),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: QrBox(
                            value: widget.orderId.toString(),
                            size: 200.0,
                          ),
                        )
                      ],
                    ),
                  ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          print("Xác nhận");
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomNav(),
                              ));
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 40, bottom: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Styles.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text("XÁC NHẬN",
                                style: TextStyle(
                                    color:
                                        Styles.boldTextColor[Config.themeMode],
                                    fontWeight: FontWeight.bold,
                                    fontSize: Styles.titleFontSize)))),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onCreateURLCompelete(String url) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebPageView(
                  url: url,
                  callback: reload,
                )));
  }

  @override
  void onError() {}
}
