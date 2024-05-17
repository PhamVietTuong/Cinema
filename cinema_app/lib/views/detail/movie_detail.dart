import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/constants.dart';
import 'package:cinema_app/views/2_showtime_selection/day_item_box.dart';
import 'package:cinema_app/views/detail/list_threater.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class MovieDetail extends StatefulWidget {
  const MovieDetail({super.key ,});
  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
   bool _showImage = true;
   bool _statusPlay=true;
  
  @override
  Widget build(BuildContext context) {
      var styles=Styles();

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Stack(
  children: [
    _showImage
      ? Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img_demo/bannerbg.jpg'),
              fit: BoxFit.cover, // Tuỳ chỉnh cách hình ảnh được hiển thị
            ),
          ),
        )
      // ignore: sized_box_for_whitespace
      : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/3 ,
        child:const WebView(
        initialUrl: 'https://www.youtube.com/embed/CCTDpYIHaPY',
        javascriptMode: JavascriptMode.unrestricted,
      ), 
      ) ,
    // Nút play
    Positioned.fill(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showImage = false;
            _statusPlay=false; // Khi nhấn vào nút play, ẩn hình ảnh và hiển thị video
          });
        },
        child: Center(
          child:
          _statusPlay?
           const Icon(
            Icons.play_circle_fill,
            size: 64,
            color: Colors.white,
          ):
          const Text(""),
        ),
      ),
    ),
  ],
),
        Card(
            elevation: 4, // Độ nổi của thẻ, tạo hiệu ứng đổ bóng
            child: Row(
              children: [
                Image.asset(
                  "assets/img_demo/bannerbg.jpg",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width/4 ,
                  height: 150,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("BIỆT ĐỘI SĂN MA",style:styles.titleTextStyle.copyWith(color: Colors.black,fontSize: 20)) ,
                         const SizedBox(height: 5,),
                      const Text("Thời lượng: 115phút",style:TextStyle(color: Colors.grey),),
                         const SizedBox(height: 10,),
                      const MovieTypeBox(fontSizeCus: 14,padding: 5, title: 'Hành động',),
                      const SizedBox(height: 10,),
                      const Row(
                        children: [
                      ShowtimeTypeBox(title: '2D',fontSizeCus: 15,),
                      AgeRestrictionBox(title: "T18",fontSizeCus: 15,),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        const Text("Đạo diễn: Gil Kenan",style: TextStyle(fontSize: 18),),
        const Text("Diễn viên: William Atherton, Emily Alyn Lind, James Acaster, Annie Potts, Ernie Hudson",style: TextStyle(fontSize: 18)),
        const Text("Mô tả phim: Sau các sự kiện của Ghostbusters: Afterlife, gia đình Spengler đang tìm kiếm cuộc sống mới ở..Xem thêm ",style: TextStyle(fontSize: 18)),
        Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: const BoxDecoration(color: Colors.white),
                child:  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [

                 DayItemBox(
                  date: DateTime(2024, 4, 19),
                  selectDay: (selectedDate) {
                    // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                    print("Ngày đã chọn: $selectedDate");
                  },
                  isSelected: true,
                ),
  DayItemBox(
                  date: DateTime(2024, 4, 20),
                  selectDay: (selectedDate) {
                    // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                    print("Ngày đã chọn: $selectedDate");
                  },
                  isSelected: false,
                ),
                  DayItemBox(
                  date: DateTime(2024, 4, 21),
                  selectDay: (selectedDate) {
                    // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                    print("Ngày đã chọn: $selectedDate");
                  },
                  isSelected: false,
                ),
   DayItemBox(
                  date: DateTime(2024, 4, 22),
                  selectDay: (selectedDate) {
                    // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                    print("Ngày đã chọn: $selectedDate");
                  },
                  isSelected: false,
                ),

   DayItemBox(
                  date: DateTime(2024, 4, 23),
                  selectDay: (selectedDate) {
                    // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                    print("Ngày đã chọn: $selectedDate");
                  },
                  isSelected: false,
                ),

                    ],
                  ),
                ),
              ),
     Column(
      children: [
        ListThreater(data: Theater(id: 1, name: 'Cinestar Quốc Thanh', address: "271 Nguyễn Trãi", phone: '00', img: 'D')),
                SizedBox(height: 10,),

        ListThreater(data: Theater(id: 2, name: 'Cinestar Đà Lạt  ', address: "Quảng trường Lâm Viên", phone: '00', img: 'D')),

      ],
    ),
      ]),
    ));
  }
}
