// ignore_for_file: avoid_print
import 'dart:async';

import 'package:cinema_app/components/count_down.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:flutter/material.dart';

 class  BookingSummaryBox extends StatefulWidget {
  const BookingSummaryBox({
    super.key,
    required this.nextScreen,
    required this.booking,
    required this.handle,
    this.totalPrice,
    this.totalTicket,
  });
  final Widget nextScreen;
  final Booking booking;
  final int? totalTicket;
  final int? totalPrice;
  final bool Function() handle;

  @override
  State<BookingSummaryBox> createState() => _BookingSummaryBoxState();
}

class _BookingSummaryBoxState extends State<BookingSummaryBox> {
  String textChair = "ghế";
  String textTotal = "Tổng cộng";
  String remaining = "Còn lại";
  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textChair),
      Styles.translate(textTotal),
    ]);
    textChair = textTranlate[0];
    textTotal = textTranlate[1];

    setState(() {});
  }
  // Đây là một stream giả định để minh họa
 
  @override
  void initState() {
    super.initState();
    tranlate();
   
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Styles.gradientTop[Config.themeMode]!,
                Styles.gradientBot[Config.themeMode]!
              ])),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Styles.backgroundContent[Config.themeMode],
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      '${widget.totalTicket ?? widget.booking.getTotalTickets()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: ' $textChair')
                            ],
                            style: TextStyle(
                                color: Styles.boldTextColor[Config.themeMode],
                                fontSize: Styles.titleFontSize)),
                      ),
                      const SizedBox(
                        width: 85,
                      ),
                      widget.booking.getTotalCombo() != 0
                          ? RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            '${widget.booking.getTotalCombo()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(text: " Combo")
                                  ],
                                  style: TextStyle(
                                      color: Styles
                                          .boldTextColor[Config.themeMode],
                                      fontSize: Styles.titleFontSize)),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.35),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Styles.boldTextColor[Config.themeMode],
                                  fontSize: Styles.titleFontSize),
                              children: [
                                TextSpan(text: '$textTotal: '),
                                TextSpan(
                                    text: Styles.formatter.format(
                                        widget.totalPrice ??
                                            widget.booking.getTotalPrice()),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.only(left: 20, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Styles.btnColor[Config.themeMode]),
                        child:  Text(Styles.formatSecond(CountDown.time), style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Styles.titleFontSize ,color: Styles.boldTextColor[Config.themeMode]
                        ),)
                      )
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!widget.handle()) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.nextScreen,
                    ));
              },
              child: Container(
                  padding: const EdgeInsets.all(13),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      color: Styles.btnColor[Config.themeMode],
                      borderRadius: BorderRadius.circular(6)),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: Styles.iconSizeInTitle,
                  )),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
 
  }
}
