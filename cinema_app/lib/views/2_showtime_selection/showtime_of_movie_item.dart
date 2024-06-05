import 'package:cinema_app/components/time_box.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_item.dart';
import 'package:flutter/material.dart';

import '../../components/movie_type_box.dart';

class ShowTimeOfMovieItem extends StatelessWidget {
  const ShowTimeOfMovieItem(
      {super.key,
      required this.movie,
      required this.booking,
      required this.selectedDate});

  final Movie movie;
  final Booking booking;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        margin: const EdgeInsets.only(bottom: 6),
        decoration:
            BoxDecoration(color: Styles.backgroundContent["dark_purple"]),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: wS * 0.27,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: -1,
                          offset: const Offset(
                              2, 4), // Độ dịch chuyển của bóng (ngang, dọc)
                        ),
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image(
                        fit: BoxFit.fitHeight,
                        image: movie.img.isEmpty
                            ? const AssetImage("assets/img/movie_white.png")
                                as ImageProvider
                            : NetworkImage("$serverUrl/Images/${movie.img}")),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${movie.name} ${movie.showTimeTypeName} (${movie.ageRestrictionName})',
                            style: TextStyle(
                                color: Styles.boldTextColor["dark_purple"],
                                fontSize: Styles.titleFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                          MovieTypeBox(
                            title: movie.movieType,
                            marginTop: 5,
                            marginBottom: 10,
                            padding: 5,
                          ),
                          Row(
                            children: [
                              ShowtimeTypeBox(
                                title: movie.showTimeTypeName,
                              ),
                              AgeRestrictionBox(
                                title: movie.ageRestrictionName,
                                marginLeft: 5,
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TimeBox(time: movie.time),
                          )
                        ]),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: wS - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Standard",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Styles.titleFontSize,
                      color: Styles.boldTextColor["dark_purple"]),
                ),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: movie.schedules
                      .firstWhere((element) =>
                          element.date.day == selectedDate.day &&
                          element.date.month == selectedDate.month)
                      .theaters
                      .firstWhere(
                          (element) => element.theaterId == booking.theater.id,
                          orElse: () => TheaterShowtime())
                      .showtimes
                      .where((element) => element.showtimeType == 0)
                      .map((e) => ShowtimeItem(
                            selectedDate: selectedDate,
                            showtimeRoom: e,
                            booking: booking,
                            movie: movie,
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Deluxe",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Styles.titleFontSize,
                        color: Styles.boldTextColor["dark_purple"])),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: movie.schedules
                      .firstWhere((element) =>
                          element.date.day == selectedDate.day &&
                          element.date.month == selectedDate.month)
                      .theaters
                      .firstWhere(
                          (element) => element.theaterId == booking.theater.id,
                          orElse: () => TheaterShowtime())
                      .showtimes
                      .where((element) => element.showtimeType == 1)
                      .map((e) => ShowtimeItem(
                            selectedDate: selectedDate,
                            showtimeRoom: e,
                            booking: booking,
                            movie: movie,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ]));
  }
}
