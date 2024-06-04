import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({super.key, required this.title, this.img = ""});
  final String title;
  final String img;
  @override
  Widget build(BuildContext context) {
  var wS=MediaQuery.of(context).size.width;
var styles=Styles();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          width: (wS-30)*0.09,
          child: Image(image: AssetImage(img))),
        Expanded(child: Text(title, )),
      ],
    );
  }
}
