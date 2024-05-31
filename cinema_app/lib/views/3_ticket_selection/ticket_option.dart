import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/btn_up_down.dart';
import 'package:cinema_app/data/models/ticket_option.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketOptionItem extends StatefulWidget {
  const TicketOptionItem(
      {super.key, required this.option, required this.upDownQuantity});
  final TicketOption option;
  final Function(bool isUp, TicketOptionItem tickOpt) upDownQuantity;
  @override
  State<TicketOptionItem> createState() => _TicketOptionItemState();
}

class _TicketOptionItemState extends State<TicketOptionItem> {
  var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  void updown(bool isUp) {
    setState(() {
      widget.upDownQuantity(isUp, widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.option.getName(),
                  style: styles.normalTextStyle,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Text(
                        formatter.format(widget.option.price),
                        style: styles.normalTextStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      )),
                  BtnUpDown(
                      colorText: styles.primaryColor,
                      opt: widget.option,
                      upDown: updown),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        widget.option.quantity.toString().padLeft(2, '0'),
                        style: styles.titleTextStyle
                            .copyWith(color: styles.primaryColor),
                      )),
                  BtnUpDown(
                    isUp: true,
                    colorText: styles.primaryColor,
                    opt: widget.option,
                    upDown: updown,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
