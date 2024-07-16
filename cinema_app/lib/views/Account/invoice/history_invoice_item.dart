import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/invoice.dart';
import 'package:flutter/material.dart';

class HistoryInvoiceItem extends StatefulWidget {
  const HistoryInvoiceItem({super.key, required this.invoice});
  final Invoice invoice;
  @override
  State<HistoryInvoiceItem> createState() => _HistoryInvoiceItemState();
}

class _HistoryInvoiceItemState extends State<HistoryInvoiceItem> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Divider(),
      Row(
        children: [
          Expanded(
            child: Text(widget.invoice.code,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Styles.boldTextColor[Config.themeMode],
                    fontSize: Styles.titleFontSize)),
          ),
          Expanded(
            child: Text(widget.invoice.theaterName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Styles.boldTextColor[Config.themeMode],
                    fontSize: Styles.titleFontSize)),
          ),
          Expanded(
            child: Text(Styles.formatter.format(widget.invoice.totalPrice),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Styles.boldTextColor[Config.themeMode],
                    fontSize: Styles.titleFontSize)),
          ),
          Expanded(
            child: Text(
              (widget.invoice.totalPrice / 1000).toStringAsFixed(
                  0),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Styles.boldTextColor[Config.themeMode],
                fontSize: Styles.titleFontSize,
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
