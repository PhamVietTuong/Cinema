import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_item.dart';
import 'package:flutter/material.dart';

import '../../data/models/showtime.dart';

class ListThreater extends StatefulWidget {
  final Theater data;

  const ListThreater({Key? key, required this.data}) : super(key: key);

  @override
  State<ListThreater> createState() => _ListThreaterState();
}

class _ListThreaterState extends State<ListThreater> {
  var isShow = true;

  @override
  Widget build(BuildContext context) {

    return Column(
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
              color: Styles.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data.name, // Sử dụng dữ liệu từ widget cha
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  isShow ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        isShow
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShowtimeItem(
                        showtimeRoom: ShowtimeRoom(),
                        booking: Booking(),
                        movie: Movie(),
                        selectedDate: DateTime.now(),
                      ),
                      ShowtimeItem(
                        showtimeRoom: ShowtimeRoom(),
                        booking: Booking(),
                        movie: Movie(),
                        selectedDate: DateTime.now(),
                      ),
                      ShowtimeItem(
                        showtimeRoom: ShowtimeRoom(),
                        booking: Booking(),
                        movie: Movie(),
                        selectedDate: DateTime.now(),
                      ),
                      ShowtimeItem(
                        showtimeRoom: ShowtimeRoom(),
                        booking: Booking(),
                        movie: Movie(),
                        selectedDate: DateTime.now(),
                      ),
                      ShowtimeItem(
                        showtimeRoom: ShowtimeRoom(),
                        booking: Booking(),
                        movie: Movie(),
                        selectedDate: DateTime.now(),
                      ),
                    ],
                  )
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
