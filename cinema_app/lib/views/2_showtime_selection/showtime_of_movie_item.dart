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
      {super.key, required this.movie, required this.booking});

  final Movie movie;
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var styles = Styles();

    return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: const BoxDecoration(color: Colors.white),
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
                              1, 4), // Độ dịch chuyển của bóng (ngang, dọc)
                        ),
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image(
                        fit: BoxFit.fitHeight, image: NetworkImage("$serverUrl/Images/${movie.img}")),
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
                            style: styles.titleTextStyle,
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
                          )
                        ]),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: wS - 30,
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: movie.schedules
                  .map((e) => ShowtimeItem(
                        showtimeRoom: e.showtimes[0],
                        booking: booking,
                        movie:  movie,
                      ))
                  .toList(),
            ),
          ),
        ]));
  }
}
