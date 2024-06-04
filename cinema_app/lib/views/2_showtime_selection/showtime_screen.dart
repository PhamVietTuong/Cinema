// ignore_for_file: avoid_print

import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/presenters/showtime_presenter.dart';
import 'package:cinema_app/views/2_showtime_selection/day_item_box.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_of_movie_item.dart';
import 'package:flutter/material.dart';

class ShowTimeSceen extends StatefulWidget {
  const ShowTimeSceen({
    super.key,
    required this.booking,
  });
  final Booking booking;
  @override
  State<ShowTimeSceen> createState() => _ShowTimeSceenState();
}

class _ShowTimeSceenState extends State<ShowTimeSceen>
    implements ShowtimeViewContract {
  late ShowtimePresenter showtimePr;

  bool isLoadingData = true;

  List<DayItemBox> days = List.filled(
      0,
      DayItemBox(
        date: DateTime.now(),
        selectDay: (DateTime value) {},
        isSelected: false,
      ),
      growable: true);
  List<Movie> movieDatas = List.filled(0, Movie(), growable: true);
  List<ShowTimeOfMovieItem> lstShowTimeMovie = List.filled(
      0,
      ShowTimeOfMovieItem(
        selectedDate: DateTime.now(),
        movie: Movie(),
        booking: Booking(),
      ),
      growable: true);

  var today = DateTime.now();
  var spaceBottom = 6.0;

  late DateTime selectedDay;

  void _selectDay(DateTime day) {
    setState(() {
      selectedDay = day;
      lstShowTimeMovie = movieDatas
          .where((e) => e.schedules.any((sch) =>
              sch.date.day == selectedDay.day &&
              sch.date.month == selectedDay.month))
          .map((e) => ShowTimeOfMovieItem(
                selectedDate: selectedDay,
                movie: e,
                booking: widget.booking,
              ))
          .toList();
    });
  }

  void loadData() {
    //creat dayString
  }

  @override
  void initState() {
    super.initState();
    selectedDay = today;
    loadData();
    showtimePr = ShowtimePresenter(this);
    showtimePr.fetchShowtimesByDate(widget.booking.theater.id);
  }

  @override
  Widget build(BuildContext context) {
    days.clear();
    //print(selectedDay);
    for (int i = 0; i < 7; i++) {
      days.add(DayItemBox(
          isSelected: today.add(Duration(days: i)) == selectedDay,
          date: today.add(Duration(days: i)),
          selectDay: _selectDay));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.backgroundContent["dark_purple"],
        toolbarHeight: 140,
        titleSpacing: 0,
        leadingWidth: 45,
        leading: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            Navigator.pop(this.context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Styles.boldTextColor["dark_purple"],
          ),
        ),
        title: Text(
          widget.booking.theater.name,
          style: TextStyle(
              color: Styles.boldTextColor["dark_purple"],
              fontSize: Styles.appbarFontSize),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Column(
            children: [
              Container(
                color:
                    Styles.backgroundColor["dark_purple"], // Màu của đường viền
                height: 1, // Độ dày của đường viền
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: Styles.backgroundContent["dark_purple"]),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: days,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                color:
                    Styles.backgroundColor["dark_purple"], // Màu của đường viền
                height: spaceBottom, // Độ dày của đường viền
              ),
            ],
          ),
        ),
      ),
      body: isLoadingData
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Đang tải...",
                    style: TextStyle(
                        color: Styles.boldTextColor["dark_purple"],
                        fontSize: Styles.titleFontSize),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Styles.backgroundColor["dark_purple"]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: lstShowTimeMovie.isNotEmpty
                          ? lstShowTimeMovie
                          : [const Text("Trống")]),
                ),
              ),
            ),
    );
  }

  @override
  void onLoadShowtimeAndMovieComplete(List<Movie> movies) {
    setState(() {
      movieDatas = movies;
      lstShowTimeMovie = movieDatas
          .where((e) => e.schedules.any((sch) =>
              sch.date.day == selectedDay.day &&
              sch.date.month == selectedDay.month))
          .map((e) => ShowTimeOfMovieItem(
                selectedDate: selectedDay,
                movie: e,
                booking: widget.booking,
              ))
          .toList();
      isLoadingData = false;
    });
  }

  @override
  void onLoadShowtimeError() {
    setState(() {
      isLoadingData = false;
    });
  }
}
