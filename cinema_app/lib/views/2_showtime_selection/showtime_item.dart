import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/views/3_ticket_selection/ticket_option_screen.dart';
import 'package:cinema_app/views/Account/account_screen.dart';
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
        Config.userInfo != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketOptionScreen(
                    selectedDate: selectedDate,
                    booking: booking,
                    showtimeRoom: showtimeRoom,
                    movie: movie,
                  ),
                ))
            : (
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AccountScreen())))
              );
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Styles.gradientTop[Config.themeMode]!,
                Styles.gradientBot[Config.themeMode]!
              ]),
        ),
        child: Container(
          width: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Styles.backgroundContent[Config.themeMode]),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          child: Center(
              child: Text(showtimeRoom.getFormatTime(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Styles.boldTextColor[Config.themeMode]))),
        ),
      ),
    );
  }
}
