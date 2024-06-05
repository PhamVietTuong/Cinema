import 'package:flutter/material.dart';

import '../config.dart';
import '../data/models/booking.dart';
import '../data/models/movie.dart';
import '../views/2_showtime_selection/showtime_item.dart';

class ShowtimeFromTheater extends StatelessWidget {
  const ShowtimeFromTheater({super.key, required this.selectedDate, required this.item, required this.movie});

  final DateTime selectedDate;
  final TheaterShowtime item;
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return     Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //thông tin của theater
                                      Container(
                                       
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Styles.backgroundContent[
                                                "dark_purple"]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.theaterName,
                                              style: TextStyle(
                                                  color: Styles.boldTextColor[
                                                      "dark_purple"],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Styles.titleFontSize),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down_sharp,
                                              size: Styles.iconSizeInTitle,
                                              color: Styles
                                                  .boldTextColor["dark_purple"],
                                            )
                                            //arrow_drop_up
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:const EdgeInsets.symmetric(vertical: 7),
                                        child: Text(
                                                item.theaterAddress,
                                                style: TextStyle(
                                                    color: Styles.textColor[
                                                        "dark_purple"],
                                                    fontSize:
                                                        Styles.textSize),
                                              ),
                                      ),
                                      //phần showtime
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        child: Wrap(
                                          runSpacing: 5,
                                          spacing: 10,
                                          children: item.showtimes.map((e) => ShowtimeItem(showtimeRoom: e, booking: Booking(), movie: movie, selectedDate: selectedDate)).toList(),
                                        ),
                                      )
                                    ],
                                  )
                                ;
  }
}