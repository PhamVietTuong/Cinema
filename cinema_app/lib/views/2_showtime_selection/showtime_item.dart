import 'package:cinema_app/constants.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/views/3_ticket_selection/ticket_option_screen.dart';
import 'package:flutter/material.dart';

class ShowtimeItem extends StatelessWidget {
  const ShowtimeItem(
      {super.key,
      required this.showtimeRoom,
      required this.booking,
      required this.movie});

  final Booking booking;
  final Movie movie;
  final ShowtimeRoom showtimeRoom;

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketOptionScreen(
                booking: booking,
                showtimeRoom: showtimeRoom,
                movie: movie,
              ),
            ));
      },
      child: Container(
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: styles.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Center(
            child: Text(showtimeRoom.getFormatTime(),
                style: styles.titleTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white))),
      ),
    );
  }
}
