import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/btn_up_down.dart';
import 'package:cinema_app/data/models/ticket_option.dart';
import 'package:flutter/material.dart';

class TicketOptionItem extends StatefulWidget {
  const TicketOptionItem(
      {super.key, required this.option, required this.upDownQuantity});
  final TicketOption option;
  final Function(bool isUp, TicketOptionItem tickOpt) upDownQuantity;
  @override
  State<TicketOptionItem> createState() => _TicketOptionItemState();
}

class _TicketOptionItemState extends State<TicketOptionItem> {
  late String textSeatTypeName;
  late String textticketTypeName;
  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(
        textSeatTypeName.contains("Ðôi") &&
                Config.languageMode != Constants.codeVNKey
            ? "Cặp đôi"
            : textSeatTypeName,
      ),
      Styles.translate(textticketTypeName),
    ]);
    textSeatTypeName = textTranlate[0];
    textticketTypeName = textTranlate[1];

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    textSeatTypeName = widget.option.seatTypeName;
    textticketTypeName = widget.option.ticketTypeName;
    tranlate();
  }

  void updown(bool isUp) {
    setState(() {
      widget.upDownQuantity(isUp, widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                Styles.gradientTop[Config.themeMode]!,
                Styles.gradientBot[Config.themeMode]!
              ])),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Styles.backgroundContent[Config.themeMode]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '$textSeatTypeName-$textticketTypeName',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Styles.textSize,
                        color: Styles.boldTextColor[Config.themeMode]),
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
                          Styles.formatter.format(widget.option.price),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Styles.boldTextColor[Config.themeMode]),
                        )),
                    BtnUpDown(
                        colorText: Styles.btnColor[Config.themeMode],
                        upDown: updown),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          widget.option.quantity.toString().padLeft(2, '0'),
                          style: TextStyle(
                              color: Styles.boldTextColor[Config.themeMode],
                              fontWeight: FontWeight.bold),
                        )),
                    BtnUpDown(
                      isUp: true,
                      colorText: Styles.btnColor[Config.themeMode],
                      upDown: updown,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
