// ignore_for_file: avoid_print

import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/presenters/theater_presenter.dart';
import 'package:cinema_app/views/1_threater_selection/theater_item.dart';
import 'package:flutter/material.dart';

class TheaterScreen extends StatefulWidget {
  const TheaterScreen({super.key});

  @override
  State<TheaterScreen> createState() => _TheaterScreenState();
}

class _TheaterScreenState extends State<TheaterScreen>
    implements TheaterViewContract {
  late TheaterPresenter theaterPr;
  bool isLoadingData = true;
  List<TheaterItem> theaterItemLst =
      List.filled(0, TheaterItem(data: Theater()), growable: true);

  @override
  void initState() {
    super.initState();
    theaterPr = TheaterPresenter(this);
    theaterPr.fetchTheaters();
  }

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
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
          child: isLoadingData
              ? Column(
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
                )
              : SingleChildScrollView(
                  child: Column(
                    children: theaterItemLst,
                  ),
                )),
    );
  }

  @override
  void onLoadTheaterComplete(List<Theater> theaters) {
    setState(() {
      theaterItemLst.clear();
      theaterItemLst =
          theaters.map((theater) => TheaterItem(data: theater)).toList();
      isLoadingData = false;
    });
  }

  @override
  void onLoadTheaterError() {
    setState(() {
      isLoadingData = false;
    });
    _showErrorDialog();
  }

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Lỗi"),
            content: const Text(
                "Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại sau."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Đóng hộp thoại
                  Navigator.of(context).pop();
                },
                child: const Text("Đóng"),
              ),
              TextButton(
                onPressed: () {
                  // Gọi hàm để tải dữ liệu lại
                  theaterPr
                      .fetchTheaters()
                      .then((value) => Navigator.of(context).pop());
                },
                child: const Text("Tải lại"),
              ),
            ],
          );
        });
  }
}
