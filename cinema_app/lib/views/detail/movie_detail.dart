import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/components/showtimes_from_theater.dart';
import 'package:cinema_app/components/time_box.dart';
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
  late DateTime selectedDate;
  late Schedule schedule;

  void _selectDay(DateTime day) {
    setState(() {
      selectedDate = day;
      schedule = _movieDetail.schedules.firstWhere(
          (element) =>
              element.date.day == selectedDate.day &&
              element.date.month == selectedDate.month,
          orElse: () => Schedule());
      //showtimePr.fetchShowtimesByDate(selectedDay, widget.booking.theater.id);
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDate = today;

    moviePr = MoviePresenter(this);
    moviePr.fetchMovieDetail(widget.movieID, widget.projectionForm);
  }

  @override
  void onLoadMovieDetailComplete(Movie movie) {
    setState(() {
      _movieDetail = movie;
      schedule = _movieDetail.schedules.firstWhere(
        (element) =>
            element.date.day == selectedDate.day &&
            element.date.month == selectedDate.month,
        orElse: () => Schedule(),
      );


      isLoadingData = false;
    });
  }

  @override
  void onLoadError() {
    setState(() {
      isLoadingData = false;
    });
  }

  @override
  void onLoadMoviesComplete(List<Movie> movies) {}
  @override
  Widget build(BuildContext context) {
    days.clear();
    for (int i = 0; i < 7; i++) {
      days.add(DayItemBox(
          isSelected: today.add(Duration(days: i)) == selectedDate,
          date: today.add(Duration(days: i)),
          selectDay: _selectDay));
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Styles.boldTextColor["dark_purple"], // Màu bạn muốn
            onPressed: () {
              Navigator.pop(this.context);
            },
          ),
          title: Text(
            "Phim",
            style: TextStyle(
              fontSize: Styles.appbarFontSize,
              color: Styles.boldTextColor["dark_purple"],
            ),
          ),
          backgroundColor: Styles.backgroundContent["dark_purple"],
        ),
        body: Container(
          decoration:
              BoxDecoration(color: Styles.backgroundColor["dark_purple"]),
          child: Center(
            child: isLoadingData
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Styles.boldTextColor["dark_purple"]!),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Đang tải...",
                          style: TextStyle(
                            fontSize: Styles.titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Styles.boldTextColor["dark_purple"],
                          ))
                    ],
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Styles.backgroundColor["dark_purple"],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  _showImage
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "$serverUrl/Images/${_movieDetail.img}"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          child: WebView(
                                            initialUrl:
                                                'https://www.youtube.com/embed/${_movieDetail.trailer}',
                                            javascriptMode:
                                                JavascriptMode.unrestricted,
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
                                            ? Icon(
                                                Icons.play_circle_fill,
                                                size: 64,
                                                color: Styles.boldTextColor[
                                                    "dark_purple"],
                                              )
                                            : const Text(""),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: Styles.defaultHorizontal,
                                    vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Styles.backgroundContent[
                                        "dark_purple"], // Màu nền của container
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                            0.3), // Màu của đổ bóng và độ trong suốt
                                        spreadRadius:
                                            3, // Độ lan rộng của đổ bóng
                                        blurRadius: 5, // Độ mờ của đổ bóng
                                        offset: const Offset(0,
                                            1), // Vị trí của đổ bóng, (dx, dy)
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      "$serverUrl/Images/${_movieDetail.img}",
                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 150,

                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _movieDetail.name,
                                          style: TextStyle(
                                              color: Styles
                                                  .boldTextColor["dark_purple"],
                                              fontSize: Styles.titleFontSize),
                                        ),
                                        TimeBox(time: _movieDetail.time),
                                        const SizedBox(height: 5),
                                        _movieDetail.movieType.isNotEmpty
                                            ? MovieTypeBox(
                                                padding: 5,
                                                title: _movieDetail.movieType,
                                              )
                                            : const SizedBox.shrink(),
                                        const SizedBox(
                                          height: 5,
                                        ), // Khoảng trống giữa loại phim và loại vé
                                        Row(
                                          children: [
                                            _movieDetail.projectionForm == 0
                                                ? const ShowtimeTypeBox(
                                                    title: '2D',
                                                  )
                                                : const ShowtimeTypeBox(
                                                    title: '3D',
                                                  ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            _movieDetail.ageRestrictionName
                                                    .isNotEmpty
                                                ? AgeRestrictionBox(
                                                    title: _movieDetail
                                                        .ageRestrictionName,
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: Styles.defaultHorizontal),
                                width: MediaQuery.of(context).size.width,
                                child: Column(children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TitleInfoMovie(title: 'Đạo diễn:'),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _movieDetail.director.isNotEmpty
                                                  ? _movieDetail.director
                                                  : 'Đang cập nhật',
                                              style: TextStyle(
                                                  color: Styles
                                                      .textColor["dark_purple"],
                                                  fontSize: Styles.textSize),
                                              maxLines: isDirectorExpanded
                                                  ? null
                                                  : 10,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (_movieDetail.director.length >
                                                20)
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
                                                  style: TextStyle(
                                                      color: Styles.textColor[
                                                          "dark_purple"],
                                                      fontSize:
                                                          Styles.titleFontSize),
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TitleInfoMovie(title: 'Diễn viên:'),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _movieDetail.actor.isNotEmpty
                                                  ? _movieDetail.actor
                                                  : 'Đang cập nhật',
                                              style: TextStyle(
                                                  color: Styles
                                                      .textColor["dark_purple"],
                                                  fontSize: Styles.textSize),
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
                                                  isExpanded2
                                                      ? 'Thu gọn'
                                                      : 'Xem thêm',
                                                  style: TextStyle(
                                                      color: Styles.textColor[
                                                          "dark_purple"],
                                                      fontSize:
                                                          Styles.textSize),
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TitleInfoMovie(title: 'Mô tả:'),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _movieDetail
                                                      .description.isNotEmpty
                                                  ? isExpanded
                                                      ? _movieDetail.description
                                                      : '${_movieDetail.description.substring(0, 50)}...'
                                                  : 'Đang cập nhật',
                                              style: TextStyle(
                                                  color: Styles
                                                      .textColor["dark_purple"],
                                                  fontSize: Styles.textSize),
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
                                                    child:  Text(
                                                      'Thu gọn',
                                                      style: TextStyle(
                                                  color: Styles.textColor[
                                                      "dark_purple"],
                                                  fontSize:
                                                      Styles.textSize),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isExpanded = true;
                                                      });
                                                    },
                                                    child:  Text(
                                                      'Xem thêm',
                                                      style: TextStyle(
                                                          color: Styles
                                                                  .textColor[
                                                              "dark_purple"],
                                                          fontSize:
                                                              Styles.textSize),
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
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                 color: Styles.backgroundContent[
                                          "dark_purple"],
                                  
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: Styles.defaultHorizontal),
                                 
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: days,
                                    ),
                                  ),
                                ),
                              ),
                              //phần schedules
                              const SizedBox(height: 5,),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child:
                                    //danh sách showtime theo theater
                                    Column(
                                        children: schedule.theaters.isNotEmpty
                                            ? schedule.theaters
                                                .map((e) => ShowtimeFromTheater(
                                                    selectedDate: selectedDate,
                                                    item: e,
                                                    movie: _movieDetail))
                                                .toList()
                                            : [
                                                Center(
                                                    child: Text(
                                                  "Dữ liệu đang được cập nhật",
                                                  style: TextStyle(
                                                      color: Styles.textColor[
                                                          "dark_purple"],
                                                      fontSize:
                                                          Styles.textSize),
                                                ))
                                              ]),
                              )
                            ])),
                  ),
          ),
        ));
  }
}
