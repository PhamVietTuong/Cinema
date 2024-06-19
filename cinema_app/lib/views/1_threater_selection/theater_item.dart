import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_screen.dart';
import 'package:flutter/material.dart';

class TheaterItem extends StatelessWidget {
  const TheaterItem({super.key, required this.data});
  final Theater data;

  String formatPhoneNumber(String phoneNumber) {
    String formattedNumber = phoneNumber.replaceAllMapped(
        RegExp(r'^(\d{3})(\d{3})(\d{4,})$'),
        (match) => '${match[1]} ${match[2]} ${match[3]}');
    return formattedNumber;
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    const borderRadius = 2.0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShowTimeSceen(booking: Booking(theater: data)),
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top:8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Styles.backgroundContent[Config.themeMode],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 1,
                spreadRadius: -1,
                offset:
                    const Offset(2, 4), // Độ dịch chuyển của bóng (ngang, dọc)
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // hình ảnh giới thiệu của từng rạp
            Container(
              width: wS * 0.3,
              height: 110,
              decoration: BoxDecoration(
                  // color: Colors.amber,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image(
                    fit: BoxFit.fitHeight,
                    image: data.img.isEmpty
                        ? const AssetImage("assets/img/theater_white.png")
                            as ImageProvider
                        : NetworkImage("$serverUrl/Images/${data.img}")),
              ),
            ),
            //phần thông tin riêng của từng rạp: địa chỉ, tên, sdt
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 3, top:3, bottom: 3),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: TextStyle(
                            color: Styles.boldTextColor[Config.themeMode],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Icon(Icons.location_on,
                              size: Styles.iconSizeInLineText, color: Styles.boldTextColor[Config.themeMode],),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Text(
                                data.address,
                                style:
                                     TextStyle(fontSize: Styles.textSize, color:Styles.textColor[Config.themeMode] ),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Icon(Icons.phone_in_talk_rounded,
                              size: Styles.iconSizeInLineText,
                            color: Styles.boldTextColor[Config.themeMode],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(
                              data.phone.isNotEmpty
                                  ? formatPhoneNumber(data.phone)
                                  : "Đang cập nhật",
                              style: TextStyle(
                                  fontSize: Styles.textSize,
                                  color: Styles.textColor[Config.themeMode]),
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
