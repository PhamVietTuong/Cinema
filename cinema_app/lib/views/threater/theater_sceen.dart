import 'package:cinema_app/models/theater.dart';
import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/threater/theater_item.dart';
import 'package:flutter/material.dart';

class TheaterScreen extends StatefulWidget {
  const TheaterScreen({super.key});

  @override
  State<TheaterScreen> createState() => _TheaterScreenState();
}

class _TheaterScreenState extends State<TheaterScreen> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    var theaters = [
      {
        "id": 1,
        "name": "Cinestar Huế",
        "address":
            "25 Hai Bà Trưng, Vĩnh Ninh, Thành phố Huế, Thừa Thiên Huế 52000",
        "phone": "02347300081",
        "img": "assets/img_demo/theater_img_1.jpg"
      },
      {
        "id": 2,
        "name": "Cinestar Bình Dương",
        "address":
            "Nhà Văn hóa Sinh viên Đại học Quốc gia TP.HCM, P. Đông Hòa, tx. Dĩ An, Bình Dương",
        "phone": "02873038881",
        "img": "assets/img_demo/theater_img_2.jpg"
      },
      {
        "id": 3,
        "name": "Cinestar Hai Bà Trưng",
        "address":
            "135 Hai Bà Trưng, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 70000",
        "phone": "02873007279",
        "img": "assets/img_demo/theater_img_3.jpg"
      },
      {
        "id": 4,
        "name": "Cinestar Đà Lạt",
        "address":
            "Quảng trường Lâm Viên, Đ. Trần Quốc Toản, Phường 10, Thành phố Đà Lạt, Lâm Đồng",
        "phone": "02633969969",
        "img": "assets/img_demo/theater_img_4.jpg"
      },
      {
        "id": 5,
        "name": "Cinestar Quốc Thanh",
        "address":
            "271 Đ. Nguyễn Trãi, Phường Nguyễn Cư Trinh, Quận 1, Thành phố Hồ Chí Minh 70000",
        "phone": "02873008881",
        "img": "assets/img_demo/theater_img_5.jpg"
      },
      {
        "id": 6,
        "name": "Cinestar Mỹ Tho",
        "address": "52 Đinh Bộ Lĩnh, Phường 3, Thành phố Mỹ Tho, Tiền Giang",
        "phone": "02737308881",
        "img": "assets/img_demo/theater_img_6.jpg"
      }
    ];
    List<TheaterItem> theaterItemLst = List.filled(
        0,
        TheaterItem(
            data: Theater(id: 1, address: "", img: "", name: "", phone: "")),
        growable: true);
        
    for (var item in theaters) {
      theaterItemLst.add(TheaterItem(data: Theater.fromJson(item)));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MUA VÉ",
          style: styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: theaterItemLst,
        ),
      )),
    );
  }
}
