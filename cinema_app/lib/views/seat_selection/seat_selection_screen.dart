import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/components/age_restriction_box.dart';
import 'package:cinema_app/views/components/movie_type_box.dart';
import 'package:cinema_app/views/components/showtime_dropdow.dart';
import 'package:cinema_app/views/components/showtime_type_box.dart';
import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    var wS = MediaQuery.of(context).size.width;
    var marginLeft = 10.0;
    var marginHorizontalScreen = 15.0;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "DUNE 2",
            style: styles.appBarTextStyle,
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  MovieTypeBox(
                    maxBoxWith: wS * 0.5 - 10,
                    fontSizeCus: 15,
                    padding: 5,
                  ),
                  ShowtimeTypeBox(
                      title: "3D", marginLeft: marginLeft, fontSizeCus: 15),
                  AgeRestrictionBox(
                      title: "T13", marginLeft: marginLeft, fontSizeCus: 15),
                  ShowtimeDropDown(
                    marginLeft: marginLeft,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(
                  width: wS * 0.2,
                  child: const Image(
                      image: AssetImage('assets/img_demo/movie_img_1.jpg')),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DUNE 2",
                        style: styles.titleTextStyle,
                      )
                    ],
                  ),
                )
              ]),
            ),
          ]),
        )));
  }
}
