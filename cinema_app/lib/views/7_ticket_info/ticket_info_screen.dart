import 'package:cinema_app/components/bottom_nav.dart';
import 'package:cinema_app/components/info_bar.dart';
import 'package:cinema_app/components/qr_box.dart';
import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class TicketInfoScreen extends StatefulWidget {
  const TicketInfoScreen({super.key});

  @override
  State<TicketInfoScreen> createState() => _TicketInfoScreenState();
}

class _TicketInfoScreenState extends State<TicketInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var sW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "THANH TOÁN",
        ),
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(children: [
            Container(
              width: sW - 30,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(
                color: Styles.primaryColor,
              ),
              child: const Center(
                  child: Text(
                "Thông Tin Giao Dịch",
              )),
            ),
            InfoBar(
              title: "Người đặt",
              value: "Nguyễn Ngọc Như Ý",
              titleMinWith: sW * 0.21,
              titleFontWeight: FontWeight.bold,
              valueFontWeight: FontWeight.bold,
            ),
            InfoBar(
              title: "Ngày đặt",
              value: "18/04/2024",
              titleMinWith: sW * 0.21,
              titleFontWeight: FontWeight.bold,
              valueFontWeight: FontWeight.bold,
            ),
            InfoBar(
              title: "Phim",
              value:
                  "Nguyễn Ngọc Như Ý lười biếngggggggggggggggggggggggggggggggggggggggggggggggggggggggggg",
              titleMinWith: sW * 0.21,
              titleFontWeight: FontWeight.bold,
              valueFontWeight: FontWeight.bold,
            ),
            InfoBar(
              title: "Ghế",
              value: "E07",
              titleMinWith: sW * 0.21,
              titleFontWeight: FontWeight.bold,
              valueFontWeight: FontWeight.bold,
            ),
            InfoBar(
              title: "Suất chiếu",
              value: "12:00",
              titleMinWith: sW * 0.21,
              titleFontWeight: FontWeight.bold,
              valueFontWeight: FontWeight.bold,
            ),
            InfoBar(
              title: "Rạp",
              value: "Bamos 24/7 quận 7",
              titleMinWith: sW * 0.21,
              titleFontWeight: FontWeight.bold,
              valueFontWeight: FontWeight.bold,
            ),
            InfoBar(
              title: "Tổng cộng",
              value: "770,000",
              titleMinWith: sW * 0.21,
              titleFontWeight: FontWeight.bold,
              valueFontWeight: FontWeight.bold,
            ),
            InfoBar(
              title: "Trạng thái",
              value: "Lười biếng thành công",
              titleMinWith: sW * 0.21,
              titleFontWeight: FontWeight.bold,
              valueFontWeight: FontWeight.bold,
            ),
            //Qr code mã vé
            Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              child: const Column(
                children: [
                  Text(
                    "Mã vé",
                  ),
                  Text(
                    "111850955",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  QrBox(
                    value: "111850955",
                    size: 200.0,
                  )
                ],
              ),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      // ignore: avoid_print
                      print("Xác nhận");
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNav(),
                          ));
                    },
                    child: Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Styles.primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          "XÁC NHẬN",
                        ))),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
