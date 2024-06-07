import 'package:cinema_app/config.dart';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/info_bar.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/components/title_bar.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/views/6_payment/payment_options.dart';
import 'package:cinema_app/views/6_payment/ticket_box.dart';
import 'package:cinema_app/views/7_ticket_info/ticket_info_screen.dart';
import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key, required this.booking});
  final Booking booking;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final List<PaymentOption> paymentOptions = [
    const PaymentOption(
      title: 'Visa, Master, JCB, AMEX, CUP',
      img: "assets/img_demo/visa_masterCard_logo.png",
    ),
    const PaymentOption(
      title: 'Ví Momo',
      img: "assets/img_demo/momo_logo.png",
    ),
    const PaymentOption(
      title: 'VNPay',
      img: "assets/img_demo/vnpay_logo.png",
    ),
  ];
  PaymentOption? selectedOption;

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.booking.theater.name,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: const Text(
                    "17/04/024 - 12:10 | Phòng: 03",
                    softWrap: true,
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(right: 15),
                child: const Text(
                  "04:55",
                ))
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1,
            color: Colors.grey,
          ),
        ),
        leading: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            Navigator.pop(this.context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        titleSpacing: 0,
        leadingWidth: 45,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(children: [
            //thông tin phim
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //poster
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: (wS - 30) * 0.25,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: const Image(
                              image: AssetImage(
                                  'assets/img_demo/movie_img_1.jpg')))),
                  //thông tin chi tiết về phim và ghế đã chọn
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dune 2",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //thể loại, giới hạn tuổi, kiểu xuất chiếu
                        Row(
                          children: [
                            MovieTypeBox(
                              title: "Khoa Học Viễn Tưởng",
                              padding: 4,
                            ),
                            ShowtimeTypeBox(
                              title: "2D",
                              padding: 1,
                              marginLeft: 15,
                            ),
                            AgeRestrictionBox(
                              title: "K",
                              marginLeft: 15,
                              padding: 2,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Thời lượng: 125 phút",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Ghế: E07",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //thông tin vé
            const TitleBar(title: "THÔNG TIN VÉ"),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const SingleChildScrollView(
                child: Row(
                  children: [
                    TicketBox(),
                    TicketBox(),
                    TicketBox(),
                    TicketBox(),
                  ],
                ),
              ),
            ),
            const InfoBar(title: "SỐ LƯỢNG", value: "1"),
            const InfoBar(title: "Tổng", value: "70,000 đ"),
            //thông bắp nước
            const TitleBar(title: "THÔNG TIN BẮP NƯỚC"),
            const InfoBar(
                img: "assets/img_demo/Combo.png",
                title: "Combo Party 2 Ngăn - VOL",
                value: "1"),
            const InfoBar(
                img: "assets/img_demo/Combo.png",
                title: "Combo Couple 2 Ngăn - VOL",
                value: "1"),
            const InfoBar(title: "Tổng", value: "700,000 đ"),
            //nhập khuyến mãi
            Container(
              decoration: const BoxDecoration(color: Color(0xFF9E9E9E)),
              width: wS,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      margin: const EdgeInsets.only(
                          top: 20, right: 15, left: 15, bottom: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      child: const TextField(
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Mã khuyến mãi",
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.card_giftcard_outlined,
                            )),
                      )),
                  const Text(
                    "ÁP DỤNG",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const TitleBar(title: "Thanh Toán"),
            const InfoBar(
              title: "Tổng cộng:",
              value: "770,000 đ",
            ),
            const InfoBar(
              title: "Giảm giá:",
              value: "0 đ",
            ),
            const InfoBar(
              title: "Còn lại:",
              value: "770,000 đ",
            ),
            Column(
              children: paymentOptions
                  .map((option) => RadioListTile<PaymentOption>(
                        dense: true,
                        value: option,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: option,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ))
                  .toList(),
            ),

            GestureDetector(
              onTap: () {
                // ignore: avoid_print
                print("Thanh Toán");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TicketInfoScreen(),
                    ));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: Styles.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "THANH TOÁN",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
