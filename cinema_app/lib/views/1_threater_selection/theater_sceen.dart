import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/1_threater_selection/theater_item.dart';
import 'package:flutter/material.dart';

import '../../data/data.dart';

class TheaterScreen extends StatefulWidget {
  const TheaterScreen({super.key});

  @override
  State<TheaterScreen> createState() => _TheaterScreenState();
}

class _TheaterScreenState extends State<TheaterScreen> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
   
    List<TheaterItem> theaterItemLst = List.filled(
        0,
        TheaterItem(
            data: Theater(id: 1, address: "", img: "", name: "", phone: "")),
        growable: true);

    for (var item in data["Theaters"]!) {
      theaterItemLst.add(TheaterItem(data: Theater.fromJson(item)));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MUA VÉ",
          style: styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: theaterItemLst,
        ),
      )),
    );
  }
}
