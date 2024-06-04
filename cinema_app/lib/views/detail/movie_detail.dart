import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/components/title_info_movie.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/presenters/movie_presenter.dart';
import 'package:cinema_app/views/2_showtime_selection/day_item_box.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail(
      {super.key, required this.movieID, required this.projectionForm});
  final String movieID;
  final int projectionForm;
  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail>
    implements MovieViewContract {
  bool _showImage = true;
  bool _statusPlay = true;
  bool isExpanded = false;
  bool isDirectorExpanded = false;
  bool isExpanded2 = false;
  bool isLoadingData = true;
  late MoviePresenter moviePr;
  late Movie _movieDetail;
  List<DayItemBox> days = List.filled(
      0,
      DayItemBox(
        date: DateTime.now(),
        selectDay: (DateTime value) {},
        isSelected: false,
      ),
      growable: true);
  var today = DateTime.now();
  late DateTime selectedDay;

  void _selectDay(DateTime day) {
    setState(() {
      selectedDay = day;
      //showtimePr.fetchShowtimesByDate(selectedDay, widget.booking.theater.id);
    });
  }

  @override

  @override
  void initState() {
    selectedDay = today;
    super.initState();
    moviePr = MoviePresenter(this);
    moviePr.fetchMovieDetail(widget.movieID, widget.projectionForm);
  }

  @override
 @override
void onLoadMovieDetailComplete(Movie movie) {
  setState(() {
    _movieDetail = movie;
    isLoadingData = false;
   
  });
}


  @override
  void onLoadMoviesError() {
    setState(() {
      isLoadingData = false;
    });
  }

  @override
  void onLoadMoviesComplete(List<Movie> movies) {}

  @override
  Widget build(BuildContext context) {
    if (isLoadingData) {
      return const CircularProgressIndicator();
    } else {
      var styles = Styles();
      days.clear();
      for (int i = 0; i < 7; i++) {
        days.add(DayItemBox(
            isSelected: today.add(Duration(days: i)) == selectedDay,
            date: today.add(Duration(days: i)),
            selectDay: _selectDay));
      }

      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          _showImage
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "$serverUrl/Images/${_movieDetail.img}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: WebView(
                                    initialUrl:
                                        'https://www.youtube.com/embed/${_movieDetail.trailer}',
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
                        margin: const EdgeInsets.all(5),
                        child: Card(
                          elevation: 4,
                          color: const Color(0xFF332E59),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "$serverUrl/Images/${_movieDetail.img}",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 150,
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _movieDetail.name,
                                      style: styles.titleTextStyle.copyWith(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        Text(
                                          '${_movieDetail.time} phút',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    _movieDetail.movieType.isNotEmpty
                                        ? MovieTypeBox(
                                            fontSizeCus: 14,
                                            padding: 5,
                                            title: _movieDetail.movieType,
                                          )
                                        : const SizedBox.shrink(),
                                    const SizedBox(
                                        height:
                                            5), // Khoảng trống giữa loại phim và loại vé
                                    Row(
                                      children: [
                                        _movieDetail.projectionForm == 0
                                            ? const ShowtimeTypeBox(
                                                title: '2D',
                                                fontSizeCus: 14,
                                              )
                                            : const ShowtimeTypeBox(
                                                title: '3D',
                                                fontSizeCus: 14,
                                              ),
                                        _movieDetail
                                                .ageRestrictionName.isNotEmpty
                                            ? AgeRestrictionBox(
                                                title: _movieDetail
                                                    .ageRestrictionName,
                                                fontSizeCus: 15,
                                              )
                                            : const SizedBox.shrink(),
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
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleInfoMovie(title: 'Đạo diễn:'),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _movieDetail.director.isNotEmpty
                                          ? _movieDetail.director
                                          : 'Đang cập nhật',
                                      style: const TextStyle(
                                          color: Color(0xFFCCCBD5),
                                          fontSize: 15),
                                      maxLines: isDirectorExpanded ? null : 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (_movieDetail.director.length > 20)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isDirectorExpanded =
                                                !isDirectorExpanded;
                                          });
                                        },
                                        child: Text(
                                          isDirectorExpanded
                                              ? 'Thu gọn'
                                              : 'Xem thêm',
                                          style: const TextStyle(
                                              color: Colors.white30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleInfoMovie(title: 'Diễn viên:'),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _movieDetail.actor.isNotEmpty
                                          ? _movieDetail.actor
                                          : 'Đang cập nhật',
                                      style: const TextStyle(
                                          color: Color(0xFFCCCBD5),
                                          fontSize: 15),
                                      softWrap: true,
                                      maxLines: isExpanded2 ? 10 : null,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (_movieDetail.actor.length > 30)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isExpanded2 = !isExpanded2;
                                          });
                                        },
                                        child: Text(
                                          isExpanded2 ? 'Thu gọn' : 'Xem thêm',
                                          style: const TextStyle(
                                            color: Colors.white30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
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
                                      _movieDetail.description.isNotEmpty
                                          ? isExpanded
                                              ? _movieDetail.description
                                              : '${_movieDetail.description.substring(0, 50)}...'
                                          : 'Đang cập nhật',
                                      style: const TextStyle(
                                        color: Color(0xFFCCCBD5),
                                        fontSize: 15,
                                      ),
                                      softWrap: true,
                                    ),
                                    const SizedBox(height: 5),
                                    isExpanded
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isExpanded = false;
                                              });
                                            },
                                            child: const Text(
                                              'Thu gọn',
                                              style: TextStyle(
                                                color: Colors.white30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isExpanded = true;
                                              });
                                            },
                                            child: const Text(
                                              'Xem thêm',
                                              style: TextStyle(
                                                color: Colors.white30,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: days,
                          ),
                        ),
                      ),
                    ])),
          ));
    }
  }
}
