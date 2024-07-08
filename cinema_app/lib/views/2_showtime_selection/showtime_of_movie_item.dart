import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/components/time_box.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_item.dart';
import 'package:flutter/material.dart';

import '../../components/age_restriction_box.dart';

class ShowTimeOfMovieItem extends StatefulWidget {
   ShowTimeOfMovieItem({
    super.key,
    required this.movie,
    required this.booking,
    required this.selectedDate,
  });

  final Movie movie;
  final Booking booking;
  final DateTime selectedDate;

  @override
  State<ShowTimeOfMovieItem> createState() => _ShowTimeOfMovieItemState();
}

class _ShowTimeOfMovieItemState extends State<ShowTimeOfMovieItem> {
  String textStandard="Tiêu chuẩn";
  String textDeluxe="Sang trọng";

   void translate() async {
    List<String> translatedTexts = await Future.wait([
      Styles.translate(widget.movie.name),
      Styles.translate(textStandard),
      Styles.translate(textDeluxe),
    ]);
    widget.movie.name=translatedTexts[0];
   textStandard=translatedTexts[1];
   textDeluxe=translatedTexts[2];

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    translate();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Styles.backgroundContent[Config.themeMode],
      ),
      child: Column(
        children: [
          _buildMovieInfo(width),
          _buildShowtimes(width),
        ],
      ),
    );
  }

  Widget _buildMovieInfo(double width) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMovieImage(width),
          Expanded(
            flex: 1,
            child: _buildMovieDetails(),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieImage(double width) {
    return Container(
      width: width * 0.27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 1,
            spreadRadius: -1,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Image(
          fit: BoxFit.fitHeight,
          image: widget.movie.img.isEmpty
              ?  AssetImage("assets/img/${Config.themeMode!.contains("light")?'movie_white':'movie_black'}.png") as ImageProvider
              : NetworkImage("$serverUrl/Images/${widget.movie.img}"),
        ),
      ),
    );
  }

  Widget _buildMovieDetails() {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.movie.getFullName(),
            style: TextStyle(
              color: Styles.boldTextColor[Config.themeMode],
              fontSize: Styles.titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          MovieTypeBox(
            title: widget.movie.movieType,
            marginTop: 5,
            marginBottom: 10,
            padding: 5,
          ),
          Row(
            children: [
              ShowtimeTypeBox(
                title: widget.movie.showTimeTypeName,
              ),
              AgeRestrictionBox(
                title: widget.movie.ageRestrictionName,
                marginLeft: 5,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TimeBox(time: widget.movie.time),
          ),
        ],
      ),
    );
  }

  Widget _buildShowtimes(double width) {
    return SizedBox(
      width: width - 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShowtimeTypeTitle(textStandard),
          _buildShowtimeItems(
            showtimeType: 0,
          ),
          const SizedBox(
            height: 10,
          ),
          _buildShowtimeTypeTitle(textDeluxe),
          _buildShowtimeItems(
            showtimeType: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildShowtimeTypeTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Styles.titleFontSize,
        color: Styles.boldTextColor[Config.themeMode],
      ),
    );
  }

  Widget _buildShowtimeItems({required int showtimeType}) {
    final movieSchedule = widget.movie.schedules.firstWhere(
      (element) =>
          element.date.day == widget.selectedDate.day &&
          element.date.month == widget.selectedDate.month,
    );
    final theaterShowtime = movieSchedule.theaters.firstWhere(
      (element) => element.theaterId == widget.booking.theater.id,
      orElse: () => TheaterShowtime(),
    );
    theaterShowtime.showtimes.sort((a, b) => a.startTime.compareTo(b.startTime));
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: theaterShowtime.showtimes
          .where(
            (showtime) =>
                showtime.showtimeType == showtimeType &&
                showtime.startTime.isAfter(DateTime.now()),
          )
          .map(
            (showtime) => ShowtimeItem(
              selectedDate: widget.selectedDate,
              showtimeRoom: showtime,
              booking: widget.booking,
              movie: widget.movie,
            ),
          )
          .toList(),
    );
  }
}
