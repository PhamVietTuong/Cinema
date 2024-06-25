import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_screen.dart';
import 'package:flutter/material.dart';

class TheaterItem extends StatelessWidget {
  const TheaterItem({super.key, required this.theater});
  final Theater theater;

  String formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAllMapped(
        RegExp(r'^(\d{3})(\d{3})(\d{4,})$'),
        (match) => '${match[1]} ${match[2]} ${match[3]}');
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
                  ShowTimeSceen(booking: Booking(theater: theater)),
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
      height: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image(
          fit: BoxFit.fitHeight,
          image: theater.img.isEmpty
              ? const AssetImage('assets/img/theater_white.png') as ImageProvider
              : NetworkImage('$serverUrl/Images/${theater.img}'),
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
              theater.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Styles.boldTextColor[Config.themeMode]),
            ),
            _buildAddressRow(),
            _buildPhoneRow(),
          ],
        ),
      ),
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
            theater.address,
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
            theater.phone.isNotEmpty
                ? formatPhoneNumber(theater.phone)
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

