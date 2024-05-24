// ignore_for_file: avoid_print

import 'package:cinema_app/constants.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/room.dart';
import 'package:cinema_app/data/models/seat.dart';
import 'package:cinema_app/data/models/showtime.dart';
import 'package:cinema_app/data/models/ticket_option.dart';
import 'package:cinema_app/presenters/room_presenter.dart';
import 'package:cinema_app/presenters/seat_presenter.dart';
import 'package:cinema_app/views/5_combo_selection/combo_screen.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/booking_summary_box.dart';
import 'package:cinema_app/components/chair_type_color_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_dropdow.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/views/4_seat_selection/seat_row.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';

class SeatScreen extends StatefulWidget {
  const SeatScreen({super.key, required this.booking, required this.showtime});

  final Booking booking;
  final Showtime showtime;

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen>
    implements RoomViewContract, SeatViewContract {
  late io.Socket socket;
  late Showtime selectedShowtime;
  late RoomPresenter roomPr;
  late SeatPresenter seatPr;

  List<Seat> seats = List.filled(0, Seat(), growable: true);
  List<int> waitingSeatIds = List.filled(0, 0, growable: true);
  List<int> selectedSeats = List.filled(0, 0, growable: true);
  Map<int, String> abcMap = {
    1: 'A',
    2: 'B',
    3: 'C',
    4: 'D',
    5: 'E',
    6: 'F',
    7: 'G',
    8: 'H',
    9: 'I',
    10: 'J',
    11: 'K',
    12: 'L',
    13: 'M',
    14: 'N',
    15: 'O',
    16: 'P',
    17: 'Q',
    18: 'R',
    19: 'S',
    20: 'T',
  };

  bool coutSeat(int seatId, bool state) {
    for (var seat in seats) {
      if (seat.id == seatId) {
        //tìm được đúng ghế cần xử lý -> lấy ra id loại ghế
        int seatType = seat.seatTypeId;
        print(seatType);
        //kiểm tra ghế có đúng với từng loại vé đã chọn
        for (var item in widget.booking.tickets) {
          // print('item seat type: ${item.seatType.id}');
          // print('item num seat : ${item.quantity}');
          if (item.seatType.id == seatType) {
            //có chọn số lượng mới xử lý
            if (item.quantity > 0) {
              //trường hợp bỏ chọn ghế
              if (state && item.count > 0) {
                setState(() {
                  item.count--;
                });
                return true;
              }

              //trường hợp chọn
              if (!state && item.count < item.quantity) {
                setState(() {
                  item.count++;
                });
                return true;
              }
            }
          }
        }

        break;
      }
    }
    print("Chọn sai loại ghế");
    return false;
  }

  List<SeatRow> renderSeatRow() {
    List<SeatRow> results = List.filled(
        0,
        SeatRow(
            seats: const [],
            name: "name",
            selelctSeat: (i, a) {
              return true;
            }),
        growable: true);

    for (int i = 1; i <= selectedShowtime.room.maxRow; i++) {
      results.add(SeatRow(
          selelctSeat: selectSeat,
          name: abcMap[i]!,
          seats: seats.where((element) => element.rowIndex == i).toList()));
    }

    return results;
  }

  Future<void> selectShowtime(Showtime showtime) async {
    setState(() {
      selectedShowtime = showtime;
      selectedSeats.clear();
      widget.booking.resetCount();
    });
    await roomPr.fetchRoomById(selectedShowtime.room.id);
    socket.emit('changeShowtime', {
      "showtime_id": selectedShowtime.id,
      "room_id": selectedShowtime.room.id
    });
  }

//truyền vào mã và trạng thái hiện tại
  bool selectSeat(int seatId, bool state) {
    if (state == false &&
        selectedSeats.length >= widget.booking.getTotalTickets()) {
      print("Đã chọn đủ số lượng ghế!");
      return false;
    }

    //kiểm tra chọn đúng loại ghế đã chọn theo vé
    if (!coutSeat(seatId, state)) {
      return false;
    }
    socket.emit(state ? 'deSelectSeat' : 'selectSeat',
        {"seat_id": seatId, "showtime_id": selectedShowtime.id});

    setState(() {
      state ? selectedSeats.remove(seatId) : selectedSeats.add(seatId);
    });

    print(selectedSeats);
    return true;
  }

  @override
  void onLoadRoomComplete(List<Room> rooms) {
    //  setState(() {
    selectedShowtime.room =
        rooms.firstWhere((room) => room.id == selectedShowtime.room.id);
    //});

    seatPr.fetchSeatsByRoomId(selectedShowtime.room.id);
  }

  @override
  void onLoadRoomError() {}

  @override
  void onLoadTicketOptionComplete(List<TicketOption> ticketOptions) {}

  @override
  void onLoadSeatComplete(List<Seat> seatLst) {
    setState(() {
      seats = seatLst;
    });
    print("onLoadSeatComplete");
  }

  @override
  void onLoadSeatError() {}

  @override
  void onLoadSeatIsSoldComplete(List<Seat> seatLst) {
    List<int> seatIdsIsSold = seatLst.map((e) => e.id).toList();

    setState(() {
      for (var seat in seats) {
        if (seatIdsIsSold.contains(seat.id)) {
          seat.status = 0;
          continue;
        }
        if (waitingSeatIds.contains(seat.id)) {
          seat.status = 3;
        }
      }
    });
    print("onLoadSeatIsSoldComplete");
  }

  @override
  void initState() {
    super.initState();
    selectedShowtime = widget.showtime;

    roomPr = RoomPresenter(this);
    seatPr = SeatPresenter(this);

    seatPr.fetchSeatsByRoomId(selectedShowtime.room.id);

    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.onConnectError((data) {
      print(data);
    });

    //xử lý khi kết nối: gửi thông tin room và showtime
    socket.on('connect', (_) {
      print('Connected to hub booking');
      socket.emit("userConnected", {
        "showtime_id": selectedShowtime.id,
        "room_id": selectedShowtime.room.id
      });
    });

    //lấy danh sách các ghế đang được các kết nối khác lựa chọn
    socket.on('getWaitingSeat', (_) {
      List<dynamic> data = _;
      print("getWaitingSeat");
      print(_);
      setState(() {
        waitingSeatIds = data.map((e) => e as int).toList();
      });
     // seatPr.fetchSeatsInTicketsByShowtimeId(selectedShowtime.id);
    });

    socket.on('checkForEmptySeats', (_) {
      var result = _;
      //print(result);

      if (result["state"] == 0 || result["state"] == 3) {
        print("Ghế đã được người khác mua hoặc chọn trước rồi!");
        for (var seat in seats) {
          if (seat.id == result["seat_id"]) {
            setState(() {
              seat.status = result["state"];

              selectedSeats.remove(result["seat_id"]);
              print(selectedSeats);
            });
            break;
          }
        }
      }
    });

    socket.on("updateSeat", (_) {
      var result = _;
      List<dynamic> ids = result["seat_id"];
      setState(() {
        for (var e in seats) {
          print(e.id);
          if (ids.contains(e.id)) {
            e.status = result["state"];
            ids.remove(e.id);
            if (ids.isEmpty) {
              break;
            }
          }
        }
      });
    });
    socket.on("resetScreen", (_) {
      widget.booking.resetCount();
      Navigator.pop(context);
    });
    socket.onDisconnect((_) {
      print("disconnected from hub booking");
    });
  }

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    var wS = MediaQuery.of(context).size.width;
    var marginLeft = 10.0;
    var marginHorizontalScreen = 15.0;
    //print(widget.booking.getTotalTickets());
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          leading: IconButton(
            alignment: Alignment.center,
            onPressed: () {
              widget.booking.resetCount();
              Navigator.pop(this.context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          titleSpacing: 0,
          leadingWidth: 45,
          title: Text(
            widget.booking.movie.name,
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
                          "${widget.booking.theater.name} - Phòng: ${selectedShowtime.room.name}",
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
                          "Suất chiếu: ${selectedShowtime.getFormatTime()} - ${selectedShowtime.getFormatDate()}",
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
                    MovieTypeBox(
                      title: widget.booking.movie.types.join(', '),
                      maxBoxWith: wS * 0.5 - 10,
                      fontSizeCus: 15,
                      padding: 5,
                    ),
                    ShowtimeTypeBox(
                        title: selectedShowtime.projectionForm.toString(),
                        marginLeft: marginLeft,
                        fontSizeCus: 15),
                    AgeRestrictionBox(
                        title: widget.booking.movie.ageRestriction.name,
                        marginLeft: marginLeft,
                        fontSizeCus: 15),
                    ShowtimeDropDown(
                      marginLeft: marginLeft,
                      showtime: selectedShowtime,
                      showtimes: widget.booking.movie.showtimes,
                      selectShowtime: selectShowtime,
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          style: styles.titleTextStyle
                              .copyWith(fontWeight: FontWeight.normal),
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
                  scrollDirection: Axis.horizontal,
                  child: Column(children: renderSeatRow()),
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
                          title: "Đơn", color: styles.singleSeatColor),
                      ChairTypeColorBox(
                          title: "Đôi", color: styles.coupleSeatColor),
                      ChairTypeColorBox(
                          title: "Đã bán", color: styles.soldColor),
                      ChairTypeColorBox(
                          title: "Đang chọn", color: styles.selectedSeatColor),
                      ChairTypeColorBox(
                          title: "Đang chờ", color: styles.waitingSeatColor),
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
                    nextScreen: const ComboScreen(),
                    booking: widget.booking,
                  ))
            ]),
          ),
        ));
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
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
