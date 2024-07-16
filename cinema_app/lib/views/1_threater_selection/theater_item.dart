import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_screen.dart';
import 'package:flutter/material.dart';

class TheaterItem extends StatefulWidget {
  const TheaterItem({super.key, required this.theater});
  final Theater theater;

  @override
  State<TheaterItem> createState() => _TheaterItemState();
}

class _TheaterItemState extends State<TheaterItem> {
  late String theaterName;
  late String theaterAddres;
  String room = "phòng";
  String seat = "ghế";
  String stateDes = "Đang tải";
  void translate() async {
    List<String> res = await Future.wait([
      Styles.translate(theaterName),
      Styles.translate(theaterAddres),
      Styles.translate(stateDes),
      Styles.translate(room),
      Styles.translate(seat),
    ]);
    theaterName = res[0];
    theaterAddres = res[1];
    stateDes = res[2];
    room = res[3];
    seat = res[4];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    theaterName = widget.theater.name;
    theaterAddres = widget.theater.address;

    translate();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const borderRadius = 2.0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShowTimeSceen(booking: Booking(theater: widget.theater)),
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Styles.backgroundContent[Config.themeMode],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 1,
                spreadRadius: -1,
                offset: const Offset(2, 4),
              ),
            ]),
        child: Row(
          children: [
            _buildImage(screenWidth, borderRadius),
            _buildInfo(borderRadius),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double screenWidth, double borderRadius) {
    return Container(
      width: screenWidth * 0.3,
      height: 130,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image(
          fit: BoxFit.fitHeight,
          image: widget.theater.img.isEmpty
              ? const AssetImage('assets/img/theater_white.png')
                  as ImageProvider
              : NetworkImage('$serverUrl/Images/${widget.theater.img}'),
        ),
      ),
    );
  }

  Widget _buildInfo(double borderRadius) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              theaterName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Styles.boldTextColor[Config.themeMode]),
            ),
            _buildAddressRow(),
            _buidStateInfo(),
            _buildPhoneRow(),
          ],
        ),
      ),
    );
  }

  _buidStateInfo() {
    return Row(
      children: [
        Icon(
          Icons.home,
          size: Styles.iconSizeInLineText,
          color: Styles.boldTextColor[Config.themeMode],
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '${widget.theater.countRoom} $room - ${widget.theater.countSeat} $seat',
          style: TextStyle(color: Styles.textColor[Config.themeMode]),
        )
      ],
    );
  }

  Widget _buildAddressRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
          size: Styles.iconSizeInLineText,
          color: Styles.boldTextColor[Config.themeMode],
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            theaterAddres,
            style: TextStyle(
                fontSize: Styles.textSize,
                color: Styles.textColor[Config.themeMode]),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.phone_in_talk_rounded,
          size: Styles.iconSizeInLineText,
          color: Styles.boldTextColor[Config.themeMode],
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            widget.theater.phone.isNotEmpty
                ? Styles.formatPhoneNumber(widget.theater.phone)
                : 'Đang cập nhật',
            style: TextStyle(
                fontSize: Styles.textSize,
                color: Styles.textColor[Config.themeMode]),
          ),
        ),
      ],
    );
  }
}
