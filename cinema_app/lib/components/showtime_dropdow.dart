import 'package:cinema_app/constants.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:flutter/material.dart';

class ShowtimeDropDown extends StatefulWidget {
  const ShowtimeDropDown(
      {super.key,
      this.marginLeft = 0.0,
      required this.showtimes,
      required this.showtime,
      required this.selectShowtime});

  final double marginLeft;
  final List<ShowtimeRoom> showtimes;
  final ShowtimeRoom showtime;
  final Function(ShowtimeRoom) selectShowtime;

  @override
  State<ShowtimeDropDown> createState() => _ShowtimeDropDownState();
}

class _ShowtimeDropDownState extends State<ShowtimeDropDown> {
  late ShowtimeRoom selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.showtime;
  }

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return Container(
      margin: EdgeInsets.only(left: widget.marginLeft),
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
          items: widget.showtimes.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value.getFormatTime()),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              // Khi người dùng chọn một mục mới từ dropdown
              setState(() {
                selectedItem = newValue;
              });
              widget.selectShowtime(newValue);
            }
          }),
    );
  }
}
