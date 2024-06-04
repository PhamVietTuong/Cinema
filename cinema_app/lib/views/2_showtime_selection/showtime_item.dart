import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/views/3_ticket_selection/ticket_option_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/showtime.dart';

class ShowtimeItem extends StatelessWidget {
  const ShowtimeItem(
      {super.key,
      required this.showtimeRoom,
      required this.booking,
      required this.movie,
      required this.selectedDate});

  final DateTime selectedDate;
  final Booking booking;
  final Movie movie;
  final ShowtimeRoom showtimeRoom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketOptionScreen(
                selectedDate: selectedDate,
                booking: booking,
                showtimeRoom: showtimeRoom,
                movie: movie,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Styles.gradientTop["dark_purple"]!,
                Styles.gradientBot["dark_purple"]!
              ]),
        ),
        child: Container(
          width: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Styles.backgroundContent["dark_purple"]),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          child: Center(
              child: Text(showtimeRoom.getFormatTime(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Styles.boldTextColor["dark_purple"]))),
        ),
      ),
    );
  }
}
