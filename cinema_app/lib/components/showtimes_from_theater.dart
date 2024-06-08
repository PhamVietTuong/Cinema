import 'package:flutter/material.dart';

import '../config.dart';
import '../data/models/booking.dart';
import '../data/models/movie.dart';
import '../views/2_showtime_selection/showtime_item.dart';

class ShowtimeFromTheater extends StatefulWidget {
  const ShowtimeFromTheater(
      {super.key,
      required this.selectedDate,
      required this.item,
      required this.movie});

  final DateTime selectedDate;
  final TheaterShowtime item;
  final Movie movie;

  @override
  State<ShowtimeFromTheater> createState() => _ShowtimeFromTheaterState();
}

class _ShowtimeFromTheaterState extends State<ShowtimeFromTheater> {
  bool isShow=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isShow = !isShow;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Styles.backgroundContent["dark_purple"],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.theaterName,
                  style: TextStyle(
                    color: Styles.boldTextColor["dark_purple"],
                    fontWeight: FontWeight.bold,
                    fontSize: Styles.titleFontSize,
                  ),
                ),
                Icon(
                  isShow
                      ? Icons.arrow_drop_up_sharp
                      : Icons.arrow_drop_down_sharp,
                  size: Styles.iconSizeInLineText,
                  color: Styles.boldTextColor["dark_purple"],
                ),
              ],
            ),
          ),
        ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: Text(
              widget.item.theaterAddress,
              style: TextStyle(
                color: Styles.textColor["dark_purple"],
                fontSize: Styles.textSize,
              ),
            ),
          ),
        //phần showtime
        if (isShow)
          SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: Wrap(
              runSpacing: 5,
              spacing: 10,
              children: widget.item.showtimes
                  .map(
                    (e) => ShowtimeItem(
                      showtimeRoom: e,
                      booking: Booking(),
                      movie: widget.movie,
                      selectedDate: widget.selectedDate,
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
