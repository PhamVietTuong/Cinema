import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  const InfoBar(
      {super.key,
      required this.title,
      this.value = "",
      this.img = "",
      this.titleMinWith = 0.0,
      this.titleFontWeight = FontWeight.normal,
      this.valueFontWeight = FontWeight.normal});
  final String title;
  final String value;
  final String img;
  final double titleMinWith;
  final FontWeight titleFontWeight;
  final FontWeight valueFontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 0.2))),
      child: Row(
        mainAxisAlignment: (titleMinWith != 0.0)
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              img != ""
                  ? Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 30,
                      child: Image(image: AssetImage(img)))
                  : const SizedBox(),
              Container(
                constraints: BoxConstraints(minWidth: titleMinWith),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16)
                      .copyWith(fontWeight: titleFontWeight),
                ),
              ),
            ],
          ),
          Expanded(
            flex: (titleMinWith != 0.0)?1:0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ).copyWith(fontWeight: valueFontWeight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
