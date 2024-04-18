import 'package:cinema_app/style.dart';
import 'package:flutter/material.dart';

class BookingSummaryBox extends StatefulWidget {
  const BookingSummaryBox({super.key, required this.nextScreen});
  final Widget nextScreen;
  @override
  State<BookingSummaryBox> createState() => _BookingSummaryBoxState();
}

class _BookingSummaryBoxState extends State<BookingSummaryBox> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
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
                          text: "0 ",
                          style: styles.titleTextStyle
                              .copyWith(color: styles.primaryColor)),
                      const TextSpan(text: "Ghế"),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                    style: styles.normalTextStyle.copyWith(color: Colors.black),
                    children: [
                      const TextSpan(text: "Tổng cộng"),
                      TextSpan(
                          text: ": 0 đ",
                          style: styles.titleTextStyle
                              .copyWith(color: styles.primaryColor)),
                    ]),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.nextScreen,
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
