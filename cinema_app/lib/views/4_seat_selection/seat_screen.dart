// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cinema_app/components/count_down.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/data/models/seat_info.dart';
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
  String textRoom = "Phòng";
  String textShowTime = "Suất chiếu";
  String textSingle = "Đơn";
  String textCouple = "Đôi";
  String textSold = "Đã bán";
  String textSelect = "Chọn";
  String textWait = "Đang chờ";
  String textScreen = "Màn hình";
  String textLoad = Constants.textLoad;
  String textTitleError = Constants.textTitleError;
  String textError = Constants.textError;
  String textClose = Constants.textClose;
  String textReload = Constants.textReload;
  late ShowtimeRoom selectedShowtime;
  late SeatPresenter seatPr;
  bool isLoading = true;
  late int countSignle;
  late int countCouple;

  int maxCol = 0;
  final hubConnection =
      HubConnectionBuilder().withUrl("$serverUrl/cinema").build();
  List<SeatRowData> seatRows = List.filled(0, SeatRowData(), growable: true);
  List<SeatInfo> waitingSeatIds = List.filled(0, SeatInfo(), growable: true);
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

  bool countSeat(Seat seat, bool state) {
    for (var row in seatRows) {
      for (var item in row.seats) {
        if (item.colIndex == seat.colIndex &&
            item.getRowName().compareTo(seat.getRowName()) == 0) {
          //tìm được đúng ghế cần xử lý
          print(item.name);
          print(item.getRowName());
          print(row.rowName);
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

  List<Widget> renderSeatRow() {
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
    if (!countSeat(seat, state)) {
      return false;
    }
    setState(() {
      state ? selectedSeats.remove(seat) : selectedSeats.add(seat);
    });
    if (selectedSeats.length > 0) {
      // cần reset
      CountDown.start();
    } else {
      //cần dừng
      CountDown.stop();
      CountDown.resetTime();
    }
    hubConnection.invoke("SeatBeingSelected", args: [
      {
        "showTimeId": selectedShowtime.showTimeId,
        "roomId": selectedShowtime.roomId,
        "InfoSeats": selectedSeats
            .map((e) => {"RowName": e.getRowName(), "ColIndex": e.colIndex})
            .toList(),
      }
    ]);

    return true;
  }

  void connectToHub() async {
    try {
      hubConnection.on("CheckForEmptySeats", handleCheckForEmptySeats);
      hubConnection.on("ListOfSeatsSold", handleListOfSeatsSold);
      hubConnection.on("UpdateSeat", (data) {
        List<SeatInfo> ids =
            (data![0] as List).map((e) => SeatInfo.fromJson(e)).toList();
        int state = data[1] as int;

        for (var row in seatRows) {
          for (var seat in row.seats) {
            var seatToCheck = ids.firstWhere(
                (element) =>
                    element.colIndex == seat.colIndex &&
                    element.rowName.compareTo(row.rowName) == 0,
                orElse: () => SeatInfo());
            if (seatToCheck.rowName != "") {
              if (seat.status == 0) {
                continue;
              }
              setState(() {
                seat.status = state;
                ids.removeWhere((element) =>
                    element.rowName.compareTo(row.rowName) == 0 &&
                    element.colIndex == seat.colIndex);
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
          "InfoSeats": [],
        }
      ]);
    } catch (e) {
      print("Error joining showtime: $e");
    }
  }

  void handleCheckForEmptySeats(data) {
    SeatInfo id = SeatInfo.fromJson(data![0]);
    int state = data[1] as int;

    if (state == 0 || state == 3) {
      print("Ghế đã được người khác mua hoặc chọn trước rồi!");
      var seat = findSeatById(id.rowName, id.colIndex);
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
    var ids = (data![0] as List).map((e) => SeatInfo.fromJson(e)).toList();
    int state = data[1] as int;
    setState(() {
      bool shouldBreak = false;

      for (var row in seatRows) {
        for (var seat in row.seats) {
          var seatToCheck = ids.firstWhere(
              (element) =>
                  element.colIndex == seat.colIndex &&
                  element.rowName.compareTo(row.rowName) == 0,
              orElse: () => SeatInfo());
          if (seatToCheck.rowName != "") {
            seat.status = state;
            ids.removeWhere((element) =>
                element.rowName.compareTo(row.rowName) == 0 &&
                element.colIndex == seat.colIndex);
            if (ids.isEmpty) {
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

  void handleGetWaitingSeat(data) {
    if (hubConnection.state == HubConnectionState.Connected) {
      setState(() {
        waitingSeatIds =
            (data[0] as List).map((e) => SeatInfo.fromJson(e)).toList();
        seatPr.fetchSeatsByRoomId(
            selectedShowtime.roomId, selectedShowtime.showTimeId);
      });
    }
  }

  Seat? findSeatById(String rowName, int colIndex) {
    var row = seatRows.firstWhere(
      (element) => element.rowName.compareTo(rowName) == 0,
      orElse: () => SeatRowData(),
    );
    if (row.rowName != "") {
      for (var seat in row.seats) {
        if (seat.colIndex == colIndex) {
          return seat;
        }
      }
    }
    return null;
  }

  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textRoom),
      Styles.translate(textShowTime),
      Styles.translate(textSingle),
      Styles.translate(textCouple),
      Styles.translate(textSold),
      Styles.translate(textSelect),
      Styles.translate(textWait),
      Styles.translate(textScreen),
      Styles.translate(textLoad),
      Styles.translate(textTitleError),
      Styles.translate(textError),
      Styles.translate(textClose),
      Styles.translate(textReload),
    ]);
    textRoom = textTranlate[0];
    textShowTime = textTranlate[1];
    textSingle = textTranlate[2];
    textCouple = textTranlate[3];
    textSold = textTranlate[4];
    textSelect = textTranlate[5];
    textWait = textTranlate[6];
    textScreen = textTranlate[7];
    textLoad = textTranlate[8];
    textTitleError = textTranlate[9];
    textError = textTranlate[10];
    textClose = textTranlate[11];
    textReload = textTranlate[12];

    setState(() {});
  }

  @override
  void onLoadSeatComplete(List<SeatRowData> seatLst) {
    setState(() {
      seatRows = seatLst;
      for (var row in seatRows) {
        if (row.seats.last.colIndex > maxCol) {
          maxCol = row.seats.last.colIndex;
          print(maxCol);
        }
      }
      bool shouldBreak = false;
      for (var row in seatRows) {
        for (var seat in row.seats) {
          var seatToCheck = waitingSeatIds.firstWhere(
              (element) =>
                  element.rowName.compareTo(row.rowName) == 0 &&
                  element.colIndex == seat.colIndex,
              orElse: () => SeatInfo());
          if (seatToCheck.rowName != "") {
            seat.status = 3;
            waitingSeatIds.removeWhere((element) =>
                element.rowName.compareTo(row.rowName) == 0 &&
                element.colIndex == seat.colIndex);
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
    tranlate();
  }

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(textTitleError),
            content: Text(textError),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Đóng hộp thoại
                  Navigator.of(context).pop();
                },
                child: Text(textClose),
              ),
              TextButton(
                onPressed: () {
                  // Gọi hàm để tải dữ liệu lại
                },
                child: Text(textReload),
              ),
            ],
          );
        });
  }

  @override
  void onLoadError() {
    setState(() {
      isLoading = false;
    });
    _showErrorDialog();
  }

  Stream<int> get countStream async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield CountDown.time;
    }
  }

  late StreamSubscription<int> subscription;
  int counter = 0;
  @override
  void initState() {
    CountDown.index = 1;
    print(CountDown.index);
    super.initState();
    countSignle = widget.booking.countingSignle();
    countCouple = widget.booking.countingCouple();
    subscription = countStream.listen((_count) {
      setState(() {});
      if (CountDown.time == 0&&CountDown.index==1) {
        Navigator.of(context).popUntil((route) {
          return counter++ >= 1 || !Navigator.of(context).canPop();
        });
      }
    });
    connectToHub();

    selectedShowtime = widget.showtime;
    seatPr = SeatPresenter(this);
  }

  @override
  void dispose() {
    hubConnection.stop();
    super.dispose();
    subscription.cancel();
    CountDown.index--;
    CountDown.resetTime();
    CountDown.stop();
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var hS = MediaQuery.of(context).size.height;

    var marginLeft = 10.0;

    return Scaffold(
        backgroundColor: Styles.backgroundColor[Config.themeMode],
        appBar: AppBar(
          backgroundColor: Styles.backgroundContent[Config.themeMode],
          toolbarHeight: 50,
          leading: IconButton(
            alignment: Alignment.center,
            onPressed: () {
              // widget.booking.resetCount();
              CountDown.stop();
              CountDown.resetTime();
              Navigator.pop(this.context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Styles.boldTextColor[Config.themeMode],
            ),
          ),
          titleSpacing: 0,
          leadingWidth: 45,
          title: Container(
            margin: const EdgeInsets.only(right: Styles.defaultHorizontal),
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
                          color: Styles.boldTextColor[Config.themeMode],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.booking.theater.name} - $textRoom: ${selectedShowtime.roomName}",
                            style: TextStyle(
                                color: Styles.boldTextColor[Config.themeMode],
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
                          color: Styles.boldTextColor[Config.themeMode],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            "$textShowTime: ${selectedShowtime.getFormatTime()} - ${selectedShowtime.getFormatDate()}",
                            softWrap: true,
                            style: TextStyle(
                                color: Styles.boldTextColor[Config.themeMode],
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
                BoxDecoration(color: Styles.backgroundColor[Config.themeMode]),
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              SizedBox(
                height: hS * 0.73,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: seatRows.length > 10 ? hS : hS * 0.8,
                    child: Column(children: [
                      //chọn vị trí ghế
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              Container(
                                width: maxCol > 6 ? wS * 2 : wS,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Stack(
                                  children: [
                                    const CurvedLineWidget(),
                                    Positioned(
                                      top: hS * 0.02,
                                      child: Container(
                                        width:
                                            maxCol > 6 ? wS * 2 - 20 : wS - 20,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "$textScreen",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Styles.titleFontSize,
                                              color: Styles.boldTextColor[
                                                  Config.themeMode]),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(children: renderSeatRow())),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: Styles.defaultHorizontal),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChairTypeColorBox(
                                  title: "$textSingle",
                                  color: Styles.singleSeatColor),
                              ChairTypeColorBox(
                                  title: "$textCouple",
                                  color: Styles.coupleSeatColor),
                              ChairTypeColorBox(
                                  title: "$textSold", color: Styles.soldColor),
                              ChairTypeColorBox(
                                  title: "$textSelect",
                                  color: Styles.selectedSeatColor),
                              ChairTypeColorBox(
                                  title: "$textWait",
                                  color: Styles.waitingSeatColor),
                            ]),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              bottom: 15, left: 8, right: 8),
                          decoration: BoxDecoration(
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
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Styles.titleColor[Config.themeMode]!
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
      size: Size(double.infinity, MediaQuery.of(context).size.height * 0.05),
      painter: CurvedLinePainter(),
    );
  }
}
