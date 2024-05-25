// ignore_for_file: avoid_print

import 'package:cinema_app/constants.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingSummaryBox extends StatelessWidget {
  const BookingSummaryBox({
    super.key,
    required this.nextScreen,
    required this.booking,
    this.totalPrice,
    this.totalTicket,
  });
  final Widget nextScreen;
  final Booking booking;
  final int? totalTicket;
  final int? totalPrice;

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    style: styles.normalTextStyle.copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                          text: '${totalTicket ?? booking.getTotalTickets()}',
                          style: styles.titleTextStyle
                              .copyWith(color: styles.primaryColor)),
                      const TextSpan(text: " Ghế"),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                    style: styles.normalTextStyle.copyWith(color: Colors.black),
                    children: [
                      const TextSpan(text: "Tổng cộng "),
                      TextSpan(
                          text: formatter
                              .format(totalPrice ?? booking.getTotalPrice()),
                          style: styles.titleTextStyle
                              .copyWith(color: styles.primaryColor)),
                    ]),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (totalTicket == 0 && booking.getTotalTickets() == 0) {
              print("stop");
              return;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => nextScreen,
                ));
          },
          child: Container(
              padding: const EdgeInsets.all(13),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                  color: styles.primaryColor,
                  borderRadius: BorderRadius.circular(6)),
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
