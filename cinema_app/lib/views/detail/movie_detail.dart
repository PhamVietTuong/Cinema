import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/components/title_info_movie.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/views/2_showtime_selection/day_item_box.dart';
import 'package:cinema_app/views/detail/list_threater.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({super.key, required this.movie});
  final Movie movie;
  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  bool _showImage = true;
  bool _statusPlay = true;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    var styles = Styles();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.white, // Màu bạn muốn
            onPressed: () {
              Navigator.pop(this.context);
            },
          ),
          title: const Text(
            "Phim",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF332E59),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF272042),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  _showImage
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "$serverUrl/Images/${widget.movie.img}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          child: WebView(
                            initialUrl:
                                'https://www.youtube.com/embed/${widget.movie.trailer}',
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
                        ),
                  // Nút play
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showImage = false;
                          _statusPlay =
                              false; // Khi nhấn vào nút play, ẩn hình ảnh và hiển thị video
                        });
                      },
                      child: Center(
                        child: _statusPlay
                            ? const Icon(
                                Icons.play_circle_fill,
                                size: 64,
                                color: Colors.white,
                              )
                            : const Text(""),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Card(
                  elevation: 4,
                  color: Color(0xFF332E59),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "$serverUrl/Images/${widget.movie.img}",
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 4,
                          height: 150,
                        ),
                        SizedBox(
                            width:
                                15), // Thêm một khoảng trống ngang giữa ảnh và nội dung
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.name,
                              style: styles.titleTextStyle
                                  .copyWith(color: Colors.white, fontSize: 18),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  '${widget.movie.time} phút',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    5), // Khoảng trống giữa tên phim và loại phim
                            widget.movie.movieType.isNotEmpty
                                ? MovieTypeBox(
                                    fontSizeCus: 14,
                                    padding: 5,
                                    title: '${widget.movie.movieType}',
                                  )
                                : SizedBox.shrink(),
                            SizedBox(
                                height:
                                    5), // Khoảng trống giữa loại phim và loại vé
                            Row(
                              children: [
                                widget.movie.showTimeTypeName.isNotEmpty
                                    ? ShowtimeTypeBox(
                                        title:
                                            '${widget.movie.showTimeTypeName}',
                                        fontSizeCus: 15,
                                      )
                                    : SizedBox.shrink(),
                                widget.movie.ageRestrictionName.isNotEmpty
                                    ? AgeRestrictionBox(
                                        title:
                                            '${widget.movie.ageRestrictionName}',
                                        fontSizeCus: 15,
                                      )
                                    : SizedBox.shrink(),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Row(
                    children: [
                      TitleInfoMovie(title: 'Đạo diễn:'),
                      Text(
                        widget.movie.director.isNotEmpty
                            ? '${widget.movie.director}'
                            : 'Đang cập nhật',
                        style:
                            TextStyle(color: Color(0xFFCCCBD5), fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TitleInfoMovie(title: 'Diễn viên:'),
                      Text(
                        widget.movie.actor.isNotEmpty
                            ? '${widget.movie.actor}'
                            : 'Đang cập nhật',
                        style:
                            TextStyle(color: Color(0xFFCCCBD5), fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleInfoMovie(title: 'Mô tả:'),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.description.isNotEmpty
                                  ? isExpanded
                                      ? '${widget.movie.description}'
                                      : '${widget.movie.description.substring(0, 100)}...'
                                  : 'Đang cập nhật',
                              style: TextStyle(
                                color: Color(0xFFCCCBD5),
                                fontSize: 15,
                              ),
                              softWrap: true,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 5),
                            isExpanded
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded =
                                            false; // Khi nhấp vào nút "Thu gọn", thu gọn nội dung
                                      });
                                    },
                                    child: Text(
                                      'Thu gọn',
                                      style: TextStyle(
                                        color: Colors
                                            .white30, // Màu xanh cho nút "Thu gọn"
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded =
                                            true; // Khi nhấp vào nút "Xem thêm", mở rộng nội dung
                                      });
                                    },
                                    child: Text(
                                      'Xem thêm',
                                      style: TextStyle(
                                        color: Colors
                                            .white30, // Màu xanh cho nút "Xem thêm"
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DayItemBox(
                        date: DateTime(2024, 4, 19),
                        selectDay: (selectedDate) {
                        },
                        isSelected: true,
                      ),
                      DayItemBox(
                        date: DateTime(2024, 4, 20),
                        selectDay: (selectedDate) {
                          // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                          // print("Ngày đã chọn: $selectedDate");
                        },
                        isSelected: false,
                      ),
                      DayItemBox(
                        date: DateTime(2024, 4, 21),
                        selectDay: (selectedDate) {
                          // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                          //  print("Ngày đã chọn: $selectedDate");
                        },
                        isSelected: false,
                      ),
                      DayItemBox(
                        date: DateTime(2024, 4, 22),
                        selectDay: (selectedDate) {
                          // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                          //  print("Ngày đã chọn: $selectedDate");
                        },
                        isSelected: false,
                      ),
                      DayItemBox(
                        date: DateTime(2024, 4, 23),
                        selectDay: (selectedDate) {
                          // Thực hiện các công việc cần thiết khi người dùng chọn ngày
                          // print("Ngày đã chọn: $selectedDate");
                        },
                        isSelected: false,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ListThreater(
                      data: Theater(
                          id: "",
                          name: 'Cinestar Quốc Thanh',
                          address: "271 Nguyễn Trãi",
                          phone: '00',
                          img: 'D')),
                  SizedBox(
                    height: 10,
                  ),
                  ListThreater(
                      data: Theater(
                          id: "",
                          name: 'Cinestar Đà Lạt  ',
                          address: "Quảng trường Lâm Viên",
                          phone: '00',
                          img: 'D')),
                ],
              ),
            ]),
          ),
        ));
  }
}
