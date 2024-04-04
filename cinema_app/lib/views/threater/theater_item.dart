import 'package:cinema_app/models/theater.dart';
import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/showtime/showtime_screen.dart';
import 'package:flutter/material.dart';

class TheaterItem extends StatelessWidget {
  const TheaterItem({super.key, required this.data});
  final Theater data;
  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var styles = Styles();
    const borderRadius = 2.0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowTimeSceen(theaterName: data.name),
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 1,
                spreadRadius: -1,
                offset:
                    const Offset(0, 4), // Độ dịch chuyển của bóng (ngang, dọc)
              ),
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // hình ảnh giới thiệu của từng rạp
            Container(
              width: wS * 0.3,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child:
                    Image(fit: BoxFit.fitHeight, image: AssetImage(data.img)),
              ),
            ),
            //phần thông tin riêng của từng rạp: địa chỉ, tên, sdt
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: styles.titleTextStyle,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on,
                              size: styles.iconSizeInLineText),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Text(
                                data.address,
                                style: styles.normalTextStyle,
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
                              size: styles.iconSizeInLineText),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(
                              data.phone,
                              style: styles.normalTextStyle,
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
