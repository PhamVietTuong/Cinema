import 'package:cinema_app/style.dart';
import 'package:cinema_app/components/btn_up_down.dart';
import 'package:flutter/material.dart';

class ComboItem extends StatefulWidget {
  const ComboItem({super.key});

  @override
  State<ComboItem> createState() => _ComboItemState();
}

class _ComboItemState extends State<ComboItem> {
  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var styles = Styles();
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 5),
              width: (wS - 20) * 0.3,
              child:
                  const Image(image: AssetImage("assets/img_demo/Combo.png"))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Combo Couple 2 Ngăn - VOL",
                  style: styles.titleTextStyle,
                ),
                Text(
                  "1 Coke 32oz - v + 1 Bắp 2 Ngăn 64OZ PM + CARAMEN",
                  style: styles.normalTextStyle,
                ),
                Text(
                  "119,000 đ",
                  style: styles.titleTextStyle
                      .copyWith(color: styles.primaryColor),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BtnUpDown(
                isUp: true,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "000",
                    style: styles.titleTextStyle,
                  )),
              const BtnUpDown()
            ],
          )
        ],
      ),
    );
  }
}
