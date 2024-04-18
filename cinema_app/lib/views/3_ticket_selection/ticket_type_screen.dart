import 'package:cinema_app/style.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_dropdow.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/views/4_seat_selection/seat_screen.dart';
import 'package:cinema_app/views/3_ticket_selection/ticket_type.dart';
import 'package:flutter/material.dart';

class TicketTypeScreen extends StatefulWidget {
  const TicketTypeScreen({super.key});

  @override
  State<TicketTypeScreen> createState() => _TicketTypeScreenState();
}

class _TicketTypeScreenState extends State<TicketTypeScreen> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    var wS = MediaQuery.of(context).size.width;
    var marginLeft = 10.0;
    var marginHorizontalScreen = 15.0;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.center,
            onPressed: () {
              Navigator.pop(this.context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          titleSpacing: 0,
          leadingWidth: 45,
          title: Text(
            "DUNE 2",
            style: styles.appBarTextStyle,
          ),
        ),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              //phần thông tin cơ bản, thể loại, hình thức chiếu, suất chiếu
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    MovieTypeBox(
                      title: "hihi",
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
              //thông tin phim, rạp, phòng, ngày giờ
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: wS * 0.13,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const Image(
                              image: AssetImage(
                                  'assets/img_demo/movie_img_1.jpg')),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "DUNE 2 (T18)",
                                  style: styles.titleTextStyle,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on,
                                        size: styles.iconSizeInLineText),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Cinestar Đà Lạt - Phòng: 05",
                                          style: styles.normalTextStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.av_timer_rounded,
                                      size: styles.iconSizeInLineText),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Suất chiếu: 12:10 - 05/04",
                                        style: styles.normalTextStyle,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              //chọn loại ghế
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                  child: const SingleChildScrollView(
                    child: Column(children: [
                     TicketType(),
                     TicketType(),
                      TicketType(),
                    ]),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 25, left: 8, right: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: const Offset(1, 1))
                      ]),
                  child: const BookingSummaryBox(
                    nextScreen: SeatScreen(),
                  ))
            ]),
          ),
        ));
  }
}
