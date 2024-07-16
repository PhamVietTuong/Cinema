import 'package:cinema_app/data/models/invoice.dart';
import 'package:flutter/material.dart';

class InvoiceDetail extends StatefulWidget {
  const InvoiceDetail({super.key, required this.invoice});
  final Invoice invoice;


  @override
  State<InvoiceDetail> createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: Column(children: [
          Text("${widget.invoice.movieImage}")
        ],),),
      ) ,
    );
  }
}