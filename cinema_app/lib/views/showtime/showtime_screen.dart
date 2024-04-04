import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/showtime/day_item_box.dart';
import 'package:cinema_app/views/showtime/showtime_item.dart';
import 'package:flutter/material.dart';

class ShowTimeSceen extends StatefulWidget {
  const ShowTimeSceen({super.key, required this.theaterName});
  final String theaterName;
  @override
  State<ShowTimeSceen> createState() => _ShowTimeSceenState();
}

class _ShowTimeSceenState extends State<ShowTimeSceen> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    var spaceBottom = 6.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 140,
        title: Text(
          widget.theaterName,
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                    ],
                  ),
                ),
              ),
              Container(
                margin:const EdgeInsets.only(bottom: 5),
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
            child: const Column(children: [
              
              //suất chiếu trong ngày
              ShowTimeItem(),
              ShowTimeItem(),
              ShowTimeItem(),
              ShowTimeItem(),
            ]),
          ),
        ),
      ),
    );
  }
}
