// ignore_for_file: avoid_print

import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/data/models/seat_row.dart';
import 'package:cinema_app/presenters/seat_presenter.dart';
import 'package:cinema_app/views/5_combo_selection/combo_screen.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/components/chair_type_color_box.dart';
import 'package:cinema_app/components/showtime_dropdow.dart';
import 'package:cinema_app/views/4_seat_selection/seat_row.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../data/models/movie.dart';
import '../../data/models/showtime.dart';

class SeatScreen extends StatefulWidget {
  const SeatScreen(
      {super.key,
      required this.booking,
      required this.showtime,
      required this.selectedDate});

  final Booking booking;
  final ShowtimeRoom showtime;
  final DateTime selectedDate;

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> implements SeatViewContract {
  late ShowtimeRoom selectedShowtime;
  late SeatPresenter seatPr;
  late int countSignle;
  late int countCouple;
  final hubConnection =
      HubConnectionBuilder().withUrl("$serverUrl/cinema").build();

  List<SeatRowData> seatRows = List.filled(0, SeatRowData(), growable: true);
  List waitingSeatIds = List.filled(0, "", growable: true);
  List<Seat> selectedSeats = List.filled(0, Seat(), growable: true);

  bool handel() {
    if (selectedSeats.isEmpty || countCouple != 0 || countSignle != 0) {
      return false;
    }
    return true;
  }

  Widget nextScreen() {
    return ComboScreen(
        hub: hubConnection,
        booking: widget.booking,
        selectedSeats: selectedSeats,
        showtime: selectedShowtime);
  }

  bool coutSeat(Seat seat, bool state) {
    for (var row in seatRows) {
      for (var item in row.seats) {
        if (item.id == seat.id) {
          //tìm được đúng ghế cần xử lý

          if (item.seatTypeName.compareTo("Ðôi") == 0) {
            //state ==true thì xử lý bỏ chọn.
            if (state == true) {
              setState(() {
                countCouple++;
              });
              return true;
            }

            //state = false và số lượng vé cho loại ghế này đang còn
            if (countCouple > 0) {
              setState(() {
                countCouple--;
              });
              return true;
            }
          } else {
            if (state == true) {
              setState(() {
                countSignle++;
              });
              return true;
            }

            if (countSignle > 0 && state == false) {
              setState(() {
                countSignle--;
              });
              return true;
            }
          }

          break;
        }
      }
    }
    print("Chọn sai loại ghế hoặc đã đủ loại ghế này");
    return false;
  }

  List<SeatRow> renderSeatRow() {
    return seatRows
        .map((e) => SeatRow(
              selelctSeat: selectSeat,
              name: e.rowName,
              seats: e.seats,
            ))
        .toList();
  }

  Future<void> selectShowtime(ShowtimeRoom showtime) async {
    setState(() {
      selectedShowtime = showtime;
      selectedSeats.clear();
      countSignle = widget.booking.countingSignle();
      countCouple = widget.booking.countingCouple();
    });
    if (hubConnection.state == HubConnectionState.Connected) {
      await hubConnection.stop();
    }
    await joinShowTime();

    //seatPr.fetchSeatsByRoomId(selectedShowtime.room.id, selectedShowtime.id);
  }

//truyền vào mã và trạng thái hiện tại
  bool selectSeat(Seat seat, bool state) {
    if (state == false &&
        selectedSeats.length >= widget.booking.getTotalTickets()) {
      print("Đã chọn đủ số lượng ghế!");
      return false;
    }

    //kiểm tra chọn đúng loại ghế đã chọn theo vé
    if (!coutSeat(seat, state)) {
      return false;
    }
    setState(() {
      state ? selectedSeats.remove(seat) : selectedSeats.add(seat);
    });
    hubConnection.invoke("SeatBeingSelected", args: [
      {
        "showTimeId": selectedShowtime.showTimeId,
        "roomId": selectedShowtime.roomId,
        "seatIds": selectedSeats.map((e) => e.id).toList(),
      }
    ]);

    return true;
  }

  void connectToHub() async {
    try {
      hubConnection.on("CheckForEmptySeats", handleCheckForEmptySeats);
      hubConnection.on("ListOfSeatsSold", handleListOfSeatsSold);
      hubConnection.on("UpdateSeat", (data) {
        List ids = data![0] as List;
        int state = data[1] as int;

        for (var row in seatRows) {
          for (var seat in row.seats) {
            if (ids.contains(seat.id)) {
              if (seat.status == 0) {
                continue;
              }
              setState(() {
                seat.status = state;
                ids.remove(seat.id);
              });
              if (ids.isEmpty) break;
            }
          }
          if (ids.isEmpty) break;
        }
      });
      hubConnection.on("GetWaitingSeat", handleGetWaitingSeat);
      hubConnection.onclose(({error}) => print("Connection Closed"));

      print("Starting connection...");

      await joinShowTime();
    } catch (e) {
      print("Connection error: $e");
    }
  }

  Future<void> joinShowTime() async {
    await hubConnection.start();
    print('hubConnectionState: ${hubConnection.state}');

    try {
      hubConnection.invoke("JoinShowTime", args: [
        {
          "showTimeId": selectedShowtime.showTimeId,
          "roomId": selectedShowtime.roomId,
          "seatIds": [],
        }
      ]);
    } catch (e) {
      print("Error joining showtime: $e");
    }
  }

  void handleCheckForEmptySeats(data) {
    String id = data![0] as String;
    int state = data[1] as int;

    if (state == 0 || state == 3) {
      print("Ghế đã được người khác mua hoặc chọn trước rồi!");
      var seat = findSeatById(id);
      if (seat != null) {
        setState(() {
          seat.status = state;
          selectedSeats.remove(seat);
          seat.seatTypeName.compareTo("Đơn") == 0
              ? countSignle++
              : countCouple++;
        });
      }
    }
  }

  void handleListOfSeatsSold(data) {
    List ids = (data![0] as List);
    int state = data[1] as int;
    setState(() {
      for (var row in seatRows) {
        for (var seat in row.seats) {
          if (ids.contains(seat.id)) {
            seat.status = state;
            ids.remove(seat.id);
            if (ids.isEmpty) break;
          }
        }
        if (ids.isEmpty) break;
      }
    });
  }

  void handleGetWaitingSeat(data) {
    if (hubConnection.state == HubConnectionState.Connected) {
      setState(() {
        waitingSeatIds = data[0];
        seatPr.fetchSeatsByRoomId(
            selectedShowtime.roomId, selectedShowtime.showTimeId);
      });
    }
  }

  Seat? findSeatById(String seatId) {
    for (var row in seatRows) {
      for (var seat in row.seats) {
        if (seat.id == seatId) {
          return seat;
        }
      }
    }
    return null;
  }

  @override
  void onLoadSeatComplete(List<SeatRowData> seatLst) {
    setState(() {
      seatRows = seatLst;

      bool shouldBreak = false;
      for (var row in seatRows) {
        for (var seat in row.seats) {
          if (waitingSeatIds.contains(seat.id)) {
            seat.status = 3;

            waitingSeatIds.remove(seat.id);
            if (waitingSeatIds.isEmpty) {
              shouldBreak = true;
              break;
            }
          }
        }
        if (shouldBreak) {
          break;
        }
      }
    });
  }

  @override
  void onLoadError() {}

  @override
  void initState() {
    super.initState();
    countSignle = widget.booking.countingSignle();
    countCouple = widget.booking.countingCouple();

    connectToHub();

    selectedShowtime = widget.showtime;
    seatPr = SeatPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var marginLeft = 10.0;
    var marginHorizontalScreen = 15.0;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.backgroundContent["dark_purple"],
          toolbarHeight: 50,
          leading: IconButton(
            alignment: Alignment.center,
            onPressed: () {
              // widget.booking.resetCount();
              Navigator.pop(this.context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Styles.boldTextColor["dark_purple"],
            ),
          ),
          titleSpacing: 0,
          leadingWidth: 45,
          title: Container(
            margin: EdgeInsets.only(right: marginHorizontalScreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: Styles.iconSizeInLineText,
                          color: Styles.boldTextColor["dark_purple"],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.booking.theater.name} - Phòng: ${selectedShowtime.roomName}",
                            style: TextStyle(
                                color: Styles.boldTextColor["dark_purple"],
                                fontSize: Styles.titleFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.av_timer_rounded,
                          size: Styles.iconSizeInLineText,
                          color: Styles.boldTextColor["dark_purple"],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Suất chiếu: ${selectedShowtime.getFormatTime()} - ${selectedShowtime.getFormatDate()}",
                            softWrap: true,
                            style: TextStyle(
                                color: Styles.boldTextColor["dark_purple"],
                                fontSize: Styles.titleFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ShowtimeDropDown(
                  marginLeft: marginLeft,
                  showtime: selectedShowtime,
                  showtimes: widget.booking.movie.schedules
                      .firstWhere((element) =>
                          element.date.day == widget.selectedDate.day &&
                          element.date.month == widget.selectedDate.month)
                      .theaters
                      .firstWhere(
                          (element) =>
                              element.theaterId == widget.booking.theater.id,
                          orElse: () => TheaterShowtime())
                      .showtimes,
                  selectShowtime: selectShowtime,
                )
              ],
            ),
          ),
        ),
        body: Center(
          child: Container(
            decoration:
                BoxDecoration(color: Styles.backgroundColor["dark_purple"]),
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              //phần thông tin cơ bản, thể loại, hình thức chiếu, suất chiếu

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Stack(
                  children: [
                    const CurvedLineWidget(),
                    Positioned(
                      top: 10,
                      child: Container(
                        width: wS - 20,
                        alignment: Alignment.center,
                        child: Text(
                          "MÀN HÌNH",
                          style: TextStyle(
                              fontSize: Styles.titleFontSize,
                              color: Styles.boldTextColor["dark_purple"]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //chọn vị trí ghế
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Column(children: renderSeatRow()),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding:
                    EdgeInsets.symmetric(horizontal: marginHorizontalScreen),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChairTypeColorBox(
                          title: "Đơn", color: Styles.singleSeatColor),
                      ChairTypeColorBox(
                          title: "Đôi", color: Styles.coupleSeatColor),
                      ChairTypeColorBox(
                          title: "Đã bán", color: Styles.soldColor),
                      ChairTypeColorBox(
                          title: "Đang chọn", color: Styles.selectedSeatColor),
                      ChairTypeColorBox(
                          title: "Đang chờ", color: Styles.waitingSeatColor),
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
                  child: BookingSummaryBox(
                    handle: handel,
                    nextScreen: nextScreen(),
                    booking: widget.booking,
                  ))
            ]),
          ),
        ));
  }

  @override
  void dispose() {
    hubConnection.stop();
    super.dispose();
  }
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Styles.titleColor["dark_purple"]!
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(5, size.height * 3 / 4) // Điểm bắt đầu
      ..cubicTo(size.width / 4, 0, size.width * 3 / 4, 0, size.width - 5,
          size.height * 3 / 4); // Điểm điều khiển và kết thúc

    canvas.drawPath(path, paint);

    final startArc = Offset(5, size.height * 3 / 4);
    canvas.drawArc(Rect.fromCircle(center: startArc, radius: 0.2), 0, 2 * 3.14,
        false, paint);

    final endArc = Offset(size.width - 5, size.height * 3 / 4);
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
