import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/components/age_restriction_box.dart';
import 'package:cinema_app/views/components/showtime_type_box.dart';
import 'package:cinema_app/views/showtime/showtime_hour.dart';
import 'package:flutter/material.dart';

import '../components/movie_type_box.dart';

class ShowTimeItem extends StatelessWidget {
  const ShowTimeItem({super.key});

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var styles = Styles();
    return Container(
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
                    child: const Image(
                        fit: BoxFit.fitHeight,
                        image: AssetImage('assets/img_demo/movie_img_1.jpg')),
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
                            "DUNE 2",
                            style: styles.titleTextStyle,
                          ),
                          const MovieTypeBox(marginTop: 5, marginBottom: 10,),
                           const Row(
                            children: [
                              ShowtimeTypeBox(title:"3D"),
                              AgeRestrictionBox(title:"T13", marginLeft: 20),
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
            child: const Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
              ],
            ),
          ),
        ]));
  }
}
