import 'package:cinema_app/data/models/theater.dart';
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
      required this.movie,
      required this.scroll});

  final DateTime selectedDate;
  final TheaterShowtime item;
  final Movie movie;
  final Function() scroll;

  @override
  State<ShowtimeFromTheater> createState() => _ShowtimeFromTheaterState();
}

class _ShowtimeFromTheaterState extends State<ShowtimeFromTheater> {
  bool isShow = false;
  void translate() async {
    List<String> translatedTexts = await Future.wait([
      Styles.translate(widget.item.theaterName),
      Styles.translate(widget.item.theaterAddress),
    ]);
    widget.item.theaterName = translatedTexts[0];
    widget.item.theaterAddress = translatedTexts[1];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.item.showtimes.sort((a, b) => a.startTime.compareTo(b.startTime));
    translate();
  }

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
            widget.scroll();
            // Cuộn xuống dưới cùng khi isShow là true
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Styles.backgroundContent[Config.themeMode],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.theaterName,
                  style: TextStyle(
                    color: Styles.boldTextColor[Config.themeMode],
                    fontWeight: FontWeight.bold,
                    fontSize: Styles.titleFontSize,
                  ),
                ),
                Icon(
                  isShow
                      ? Icons.arrow_drop_up_sharp
                      : Icons.arrow_drop_down_sharp,
                  size: Styles.iconSizeInLineText,
                  color: Styles.boldTextColor[Config.themeMode],
                ),
              ],
            ),
          ),
        ),
        //phần showtime
        if (isShow)
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  child: Text(
                    widget.item.theaterAddress,
                    style: TextStyle(
                      color: Styles.textColor[Config.themeMode],
                      fontSize: Styles.textSize,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Wrap(
                    runSpacing: 5,
                    spacing: 10,
                    children: widget.item.showtimes
                        .where(
                          (showtime) =>
                              showtime.startTime.isAfter(DateTime.now()),
                        )
                        .map(
                          (e) => ShowtimeItem(
                            showtimeRoom: e,
                            booking: Booking(
                                theater: Theater(
                                    id: widget.item.theaterId,
                                    name: widget.item.theaterName)),
                            movie: widget.movie,
                            selectedDate: widget.selectedDate,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
