import 'package:cinema_app/data/data.dart';
import 'package:cinema_app/data/models/age_restriction.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/movie_type.dart';
import 'package:cinema_app/data/models/showtime_type.dart';
import 'package:cinema_app/style.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_hour.dart';
import 'package:flutter/material.dart';

import '../../components/movie_type_box.dart';

class ShowTimeOfMovieItem extends StatelessWidget {
  const ShowTimeOfMovieItem(
      {super.key,
      required this.movieId,
      required this.showTimeTypeId,
      required this.theaterId, required this.day});
  final int movieId;
  final int showTimeTypeId;
  final int theaterId;
  final String day;
  void loadData() {}
  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var styles = Styles();
    //load data movie
    Movie movie = Movie.fromJson(
        data["Movies"]!.singleWhere((element) => element["id"] == movieId));
    //load showtimeType
    ShowTimeType showtimeType = ShowTimeType.fromJson(data["ShowTimeTypes"]
        ?.singleWhere((element) => element["id"] == showTimeTypeId));
    //load movie type
    List<MovieType> movieTypes = List.filled(0, MovieType(), growable: true);
    data["MovieTypeDetails"]!
        .where((movieTypeDetail) => movieTypeDetail["movieId"] == movieId)
        .forEach((movieTypeDetail) {
      movieTypes.add(MovieType.fromJson(data["MovieTypes"]!.singleWhere(
          (element) => element["id"] == movieTypeDetail["movieTypeId"])));
    });
    String movieTypeString = "";
    for (var element in movieTypes) {
      element != movieTypes.last
          ? movieTypeString += "${element.name}, "
          : movieTypeString += element.name;
    }
    //load ageRestriction
    AgeRestriction ageRestriction = AgeRestriction.fromJson(
        data["AgeRestrictions"]!
            .singleWhere((element) => element["id"] == movie.ageRestrictionId));
    //load showtime hour
    List<ShowTimeHour> showtimeHours =
        List.filled(0, const ShowTimeHour(title: ""), growable: true);
    data["ShowTimes"]!
        .where((showtime) =>
            showtime["theaterId"] == theaterId &&
            showtime["movieId"] == movieId&&
            showtime["day"]==day)
        .forEach((element) {
      showtimeHours.add(ShowTimeHour(title: element["startTime"]));
    });
    
    return showtimeHours.isEmpty?const SizedBox(): Container(
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
                        fit: BoxFit.fitHeight, image: AssetImage(movie.img)),
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
                            movie.name,
                            style: styles.titleTextStyle,
                          ),
                          MovieTypeBox(
                            title: movieTypeString,
                            marginTop: 5,
                            marginBottom: 10,
                            padding: 5,
                          ),
                          Row(
                            children: [
                              ShowtimeTypeBox(
                                  title: showtimeType.name.split("-")[0]),
                              AgeRestrictionBox(
                                  title: ageRestriction.name, marginLeft: 20),
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
              children: showtimeHours,
            ),
          ),
        ]));
  }
}
