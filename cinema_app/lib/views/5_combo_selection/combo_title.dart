import 'package:cinema_app/config.dart';
import 'package:cinema_app/views/5_combo_selection/combo_item.dart';
import 'package:flutter/material.dart';

class ComboTitle extends StatefulWidget {
  const ComboTitle({super.key});

  @override
  State<ComboTitle> createState() => _ComboTitleState();
}

class _ComboTitleState extends State<ComboTitle> {
  var isShow = true;
  List<ComboItem> comboItems=[const ComboItem(),
          const ComboItem(),
          const ComboItem(),];
  @override
  Widget build(BuildContext context) {
    return 
     Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isShow = !isShow;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Styles.primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Combo 2 ngăn",
                  ),
                  Icon(isShow
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up)
                ],
              ),
            ),
          ),
          isShow?
            Column(
              children: comboItems,
            )
          :const SizedBox()
        ],
    );
  }
}
