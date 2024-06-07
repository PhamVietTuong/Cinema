import 'package:cinema_app/components/btn_up_down.dart';
import 'package:cinema_app/data/models/food_and_drink.dart';
import 'package:flutter/material.dart';

class ComboItem extends StatefulWidget {
  const ComboItem({super.key, required this.item});

  final FoodAndDrink item;
  @override
  State<ComboItem> createState() => _ComboItemState();
}

class _ComboItemState extends State<ComboItem> {
  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
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
                 widget.item.name,
                ),
                Text(
                 widget.item.description,
                ),
                Text(
                 widget.item.price.toString(),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BtnUpDown(
                isUp: true,
                upDown: (bool i) {},
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "000",
                  )),
              BtnUpDown(
                upDown: (bool i) {},
              )
            ],
          )
        ],
      ),
    );
  }
}
