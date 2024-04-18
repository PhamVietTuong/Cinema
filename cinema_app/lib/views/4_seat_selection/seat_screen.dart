import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/5_combo_selection/combo_screen.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/components/chair_type_color_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_dropdow.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/views/4_seat_selection/seat_row.dart';
import 'package:flutter/material.dart';

class SeatScreen extends StatefulWidget {
  const SeatScreen({super.key});

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    var wS = MediaQuery.of(context).size.width;
    var marginLeft = 10.0;
    var marginHorizontalScreen = 15.0;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
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
          actions: [
            Container(
              margin: EdgeInsets.only(right: marginHorizontalScreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: styles.iconSizeInLineText),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Cinestar Đà Lạt - Phòng: 05",
                          style: styles.normalTextStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.av_timer_rounded,
                          size: styles.iconSizeInLineText),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Suất chiếu: 12:10 - 05/04",
                          style: styles.normalTextStyle,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              //phần thông tin cơ bản, thể loại, hình thức chiếu, suất chiếu
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                margin: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    MovieTypeBox(title: "hihi",
                      maxBoxWith: wS * 0.5 - 10,
                      fontSizeCus: 15,
                      padding: 5,
                    ),
                    ShowtimeTypeBox(
                        title: "3D",
                        marginLeft: marginLeft,
                        fontSizeCus: 15),
                    AgeRestrictionBox(
                        title: "T13",
                        marginLeft: marginLeft,
                        fontSizeCus: 15),
                    ShowtimeDropDown(
                      marginLeft: marginLeft,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Stack(
                  children: [
                    const CurvedLineWidget(),
                    Positioned(
                      top: 10,
                      child: Container(
                        width: wS - 80,
                        alignment: Alignment.center,
                        child: Text(
                          "MÀN HÌNH",
                          style: styles.titleTextStyle
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //chọn vị trí ghế
              const Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(children: [
                    SeatRow(),
                    SeatRow(),
                    SeatRow(),
                    SeatRow(),
                    SeatRow(),
                    SeatRow(),
                    SeatRow(),
                    SeatRow(),
                    SeatRow(),
                    SeatRow(),
                  ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding:
                    EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChairTypeColorBox(
                          title: "Ghế đơn", color: styles.singleSeatColor),
                      ChairTypeColorBox(
                          title: "Ghế đôi", color: styles.coupleSeatColor),
                      ChairTypeColorBox(
                          title: "Đã bán", color: styles.soldColor),
                      ChairTypeColorBox(
                          title: "Đang chọn", color: styles.selectedSeatColor),
                    ]),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
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
                    nextScreen: ComboScreen()
                  ))
            ]),
          ),
        ));
  }
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(10, size.height * 3 / 4) // Điểm bắt đầu
      ..cubicTo(size.width / 4, 0, size.width * 3 / 4, 0, size.width - 10,
          size.height * 3 / 4); // Điểm điều khiển và kết thúc

    canvas.drawPath(path, paint);

    final startArc = Offset(10, size.height * 3 / 4);
    canvas.drawArc(Rect.fromCircle(center: startArc, radius: 0.2), 0, 2 * 3.14,
        false, paint);

    final endArc = Offset(size.width - 10, size.height * 3 / 4);
    canvas.drawArc(Rect.fromCircle(center: endArc, radius: 0.2), 0, 2 * 3.14,
        false, paint);
  }

  @override
  bool shouldRepaint(CurvedLinePainter oldDelegate) {
    return false;
  }
}

class CurvedLineWidget extends StatelessWidget {
  const CurvedLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 35),
      painter: CurvedLinePainter(),
    );
  }
}
