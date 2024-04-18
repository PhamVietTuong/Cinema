import 'package:cinema_app/style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowtimeDropDown extends StatefulWidget {
  const ShowtimeDropDown({super.key, this.marginLeft = 0.0});
  final double marginLeft;

  @override
  State<ShowtimeDropDown> createState() => _ShowtimeDropDownState();
}

class _ShowtimeDropDownState extends State<ShowtimeDropDown> {
  final List<String> items = [
    '00:00',
    '00:01',
    '00:02',
    '00:03',
    '00:04',
    '00:05',
    '00:06',
    '00:07',
    '00:08',
    '00:09',
    '00:10',
    '00:11'
  ];

  String selectedItem = '00:00';

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      margin: widget.marginLeft != 0.0
          ? EdgeInsets.only(left: widget.marginLeft)
          : const EdgeInsets.all(0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: styles.borderWith, borderRadius: BorderRadius.circular(4)),
      child: DropdownButton(
          underline: const SizedBox(),
          isDense: true,
          itemHeight: null,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          value: selectedItem,
          menuMaxHeight: 400,
          items: items.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              // Khi người dùng chọn một mục mới từ dropdown
              setState(() {
                selectedItem = newValue;
              });
            }
          }),
    );
  }
}
