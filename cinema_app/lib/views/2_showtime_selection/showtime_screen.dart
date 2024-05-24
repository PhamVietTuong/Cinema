// ignore_for_file: avoid_print

import 'package:cinema_app/constants.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:cinema_app/presenters/showtime_presenter.dart';
import 'package:cinema_app/views/2_showtime_selection/day_item_box.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_of_movie_item.dart';
import 'package:flutter/material.dart';

import '../../presenters/movie_presenter.dart';

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
    //implements MovieViewContract
    //, ShowtimeViewContract
     {
 // late MoviePresenter moviePr;
 // late ShowtimePresenter showtimePr;

  bool isLoadingData = true;

  Set<int> movieIds = Set.identity();
  List<Showtime> showtimeOfDate = List.filled(0, Showtime(), growable: true);
  List<DayItemBox> days = List.filled(
      0,
      DayItemBox(
        date: DateTime.now(),
        selectDay: (DateTime value) {},
        isSelected: false,
      ),
      growable: true);
  List<ShowTimeOfMovieItem> lstShowTimeMovie = List.filled(
      0,
      ShowTimeOfMovieItem(
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
    //  showtimePr.fetchShowtimesByDate(selectedDay, widget.booking.theater.id);
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
    //moviePr = MoviePresenter(this);
    //showtimePr = ShowtimePresenter(this);

   // showtimePr.fetchShowtimesByDate(today, widget.booking.theater.id);
  }

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
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
        backgroundColor: Colors.white,
        toolbarHeight: 140,
        titleSpacing: 0,
        leadingWidth: 45,
        leading: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            Navigator.pop(this.context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          widget.booking.theater.name,
          style: styles.appBarTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Column(
            children: [
              Container(
                color: Colors.grey, // Màu của đường viền
                height: 0.5, // Độ dày của đường viền
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: days,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                color: Colors.grey, // Màu của đường viền
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
                    style: styles.titleTextStyle,
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: lstShowTimeMovie.isNotEmpty?lstShowTimeMovie:[Text("Trống")]),
                ),
              ),
            ),
    );
  }

  // @override
  // void onLoadMovieComplete(List<Movie> movies) {
  //   setState(() {
  //     lstShowTimeMovie.clear();
  //     for (var movie in movies) {
  
  //       movie.showtimes = showtimeOfDate
  //           .where((showtime) => showtime.movieId == movie.id)
  //           .toList();
  //     }

  //     lstShowTimeMovie = movies
  //         .map((movie) => ShowTimeOfMovieItem(
  //               movie: movie,
  //               booking: widget.booking,
  //             ))
  //         .toList();
      
  //     isLoadingData = false;
  //   });
  // }

  // @override
  // void onLoadMovieError() {
  //   isLoadingData = false;
  // }

  // @override
  // void onLoadShowtimeComplete(List<Showtime> showtimes) {
  //   setState(() {
  //     showtimeOfDate = showtimes;
  //     movieIds.clear();
  //     for (var showtime in showtimes) {
  //       movieIds.add(showtime.movieId);
  //     }
  //   });
  //   //  print(movieIds.toList());
  //   if (movieIds.toList().isNotEmpty) {
  //     moviePr.fetchMoviesByIds(movieIds.toList());
  //   } else {
  //     onLoadMovieComplete([]);
  //   }
  // }

  // @override
  // void onLoadShowtimeError() {
  //   isLoadingData = false;
  // }
}
