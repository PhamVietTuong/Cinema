import 'package:cinema_app/style.dart';
import 'package:cinema_app/components/btn_up_down.dart';
import 'package:flutter/material.dart';

class TicketType extends StatefulWidget {
  const TicketType({super.key});

  @override
  State<TicketType> createState() => _TicketTypeState();
}

class _TicketTypeState extends State<TicketType> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ĐƠN Người lớn",
            style: styles.normalTextStyle,
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    "70,000 đ",
                    style: styles.normalTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  )),
              BtnUpDown(colorText: styles.primaryColor),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "00",
                    style: styles.titleTextStyle.copyWith(color: styles.primaryColor),
                  )),
              BtnUpDown(isUp: true, colorText: styles.primaryColor),
            ],
          )
        ],
      ),
    );
  }
}
