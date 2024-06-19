import 'package:cinema_app/components/bottom_nav.dart';
import 'package:cinema_app/components/info_bar.dart';
import 'package:cinema_app/components/qr_box.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:flutter/material.dart';

class TicketInfoScreen extends StatefulWidget {
  const TicketInfoScreen(
      {super.key, required this.result, required this.booking});
  final Object result;
  final Booking booking;
  @override
  State<TicketInfoScreen> createState() => _TicketInfoScreenState();
}

class _TicketInfoScreenState extends State<TicketInfoScreen> {
  late final DateTime today;

  String formatDay(DateTime day) {
    return '${day.day.toString().padLeft(2,"0")}/${day.month.toString().padLeft(2, "0")}/${day.year}';
  }

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var sW = MediaQuery.of(context).size.width;
    var bW = 1.0;
    return Scaffold(
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Container(
            decoration:
                BoxDecoration(color: Styles.backgroundColor[Config.themeMode]),
            child: Column(children: [
              InfoBar(
                title: "Người đặt",
                value: "Nguyễn Ngọc Như Ý",
                titleMinWith: sW * 0.21,
                botBorderW: bW,
              ),
              InfoBar(
                title: "Ngày đặt",
                value: formatDay(today),
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
              // InfoBar(
              //   title: "Tổng cộng",
              //   value: Styles.formatter.format(widget.booking.getTotalPrice()),
              //   botBorderW: 0.5,
              //   titleMinWith: sW * 0.21,
              // ),
              InfoBar(
                title: "Trạng thái",
                value: "Thành công",
                botBorderW: bW,
                titleMinWith: sW * 0.21,
              ),
              //Qr code mã vé
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
                    Text(widget.result.toString(),
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
                      child:  QrBox(
                        value: widget.result.toString(),
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
                        // ignore: avoid_print
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
                                  color: Styles.boldTextColor[Config.themeMode],
                                  fontWeight: FontWeight.bold,
                                  fontSize: Styles.titleFontSize)))),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
