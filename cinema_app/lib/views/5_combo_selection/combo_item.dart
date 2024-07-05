import 'package:cinema_app/components/btn_up_down.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/food_and_drink.dart';
import 'package:flutter/material.dart';

class ComboItem extends StatefulWidget {
  const ComboItem({super.key, required this.item, required this.function});
  
  final FoodAndDrink item;
  final Function(bool isUp, FoodAndDrink combo) function;
  @override
  State<ComboItem> createState() => _ComboItemState();
}

class _ComboItemState extends State<ComboItem> {
  late String textNameCombo ;
  late String textDes;
  void tranlate () async{
    List<String> textTranlate= await Future.wait([
      Styles.translate(textNameCombo),
      Styles.translate(textDes),
    ]);
    textNameCombo=textTranlate[0];
    textDes=textTranlate[1];
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    textNameCombo= widget.item.name;
    textDes=widget.item.description;
    tranlate();
  }
   void updown(bool isUp) {
    setState(() {
      widget.function(isUp, widget.item);
    });
  }
  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Styles.backgroundContent[Config.themeMode],
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: (wS - 20) * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const Image(
                      image: AssetImage("assets/img_demo/Combo.png")))),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   textNameCombo,
                    style: TextStyle(
                        fontSize: Styles.titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Styles.boldTextColor[Config.themeMode]),
                  ),
                  Text(textDes,
                      style: TextStyle(
                          fontSize: Styles.textSize,

                          color: Styles.textColor[Config.themeMode])),
                  Text(Styles.formatter.format(widget.item.price),
                      style: TextStyle(
                          fontSize: Styles.textSize,
                          fontWeight: FontWeight.bold,
                          color: Styles.textColor[Config.themeMode])),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BtnUpDown(
                  isUp: true,
                  upDown: updown,
                  colorText: Styles.btnColor[Config.themeMode],
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      widget.item.quantity.toString().padLeft(2, '0'),
                      style: TextStyle(
                          fontSize: Styles.textSize,
                          fontWeight: FontWeight.bold,
                          color: Styles.boldTextColor[Config.themeMode]),
                    )),
                BtnUpDown(
                  upDown: updown,
                  colorText: Styles.btnColor[Config.themeMode],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
