// ignore_for_file: avoid_print

import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:flutter/material.dart';

class BookingSummaryBox extends StatelessWidget {
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
                                      '${totalTicket ?? booking.getTotalTickets()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(text: " Ghế")
                            ],
                            style: TextStyle(
                                color: Styles.boldTextColor[Config.themeMode],
                                fontSize: Styles.titleFontSize)),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      booking.getTotalCombo() != 0
                          ? RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '${booking.getTotalCombo()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(text: " Combo")
                                  ],
                                  style: TextStyle(
                                      color:
                                          Styles.boldTextColor[Config.themeMode],
                                      fontSize: Styles.titleFontSize)),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Styles.boldTextColor[Config.themeMode],
                            fontSize: Styles.titleFontSize),
                        children: [
                          const TextSpan(text: "Tổng cộng "),
                          TextSpan(
                              text: Styles.formatter.format(
                                  totalPrice ?? booking.getTotalPrice()),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!handle()) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nextScreen,
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
}
