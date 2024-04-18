import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/2_showtime_selection/day_item_box.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_of_movie_item.dart';
import 'package:flutter/material.dart';

import '../../data/data.dart';

class ShowTimeSceen extends StatefulWidget {
  const ShowTimeSceen({super.key, required this.theaterId});
  final int theaterId;

  @override
  State<ShowTimeSceen> createState() => _ShowTimeSceenState();
}

class _ShowTimeSceenState extends State<ShowTimeSceen> {
  List<DayItemBox> days = List.filled(
      0,
      DayItemBox(
        date: DateTime.now(),
        selectDay: (DateTime value) {},
        isSelected: false,
      ),
      growable: true);
  late String theaterName;
  List<ShowTimeOfMovieItem> lstShowTimeMovie = List.filled(
      0,
      const ShowTimeOfMovieItem(
        movieId: 1,
        showTimeTypeId: 1,
        theaterId: 1,
        day: "",
      ),
      growable: true);
  var today = DateTime.now();
  var spaceBottom = 6.0;
  late DateTime selectedDay;
  late String dayString;

  void _selectDay(DateTime day) {
    setState(() {
      selectedDay = day;
      loadData();
    });
  }

  void loadData() {
    //creat dayString
    dayString =
        "${selectedDay.day.toString().padLeft(2, '0')}/${selectedDay.month.toString().padLeft(2, '0')}/${selectedDay.year.toString().padLeft(2, "0")}";
    // load theaterName
    theaterName = data["Theaters"]!
        .singleWhere((e) => e["id"] == widget.theaterId)["name"];
    //load movie
    lstShowTimeMovie.clear();
    List<int> movieIds = List.filled(0, 0, growable: true);
    data["ShowTimes"]!
        .where((e) => e["theaterId"] == widget.theaterId)
        .forEach((e) {
      if (!movieIds.contains(e["movieId"])) {
        lstShowTimeMovie.add(ShowTimeOfMovieItem(
          movieId: e["movieId"],
          showTimeTypeId: e["showTimeTypeId"],
          theaterId: widget.theaterId,
          day: dayString,
        ));
        movieIds.add(e["movieId"]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDay = today;
    loadData();
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
          theaterName,
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(color: Colors.grey),
            child: Column(children: lstShowTimeMovie),
          ),
        ),
      ),
    );
  }
}
