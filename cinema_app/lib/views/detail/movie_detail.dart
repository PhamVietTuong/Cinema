import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/components/age_restriction_box.dart';
import 'package:cinema_app/views/components/movie_type_box.dart';
import 'package:cinema_app/views/components/showtime_type_box.dart';
import 'package:cinema_app/views/detail/itemAddress.dart';
import 'package:cinema_app/views/showtime/day_item_box.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class MovieDetail extends StatefulWidget {
  const MovieDetail({super.key});

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
          height: MediaQuery.of(context).size.height / 3,
        child:const WebView(
        initialUrl: 'https://www.youtube.com/embed/XDXgU6u3WXk',
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
                      const MovieTypeBox(fontSizeCus: 14,padding: 5),
                      const SizedBox(height: 10,),
                      const Row(
                        children: [
                      ShowtimeTypeBox(title: '2D',colorText: Colors.black,fontSizeCus: 15,),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                      DayItemBox(),
                    ],
                  ),
                ),
              ),
        const ItemAddress(),
      ]),
    ));
  }
}
