import 'package:cinema_app/components/actor_list.dart';
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
import 'package:intl/intl.dart';
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
  int _selectedTabIndex = 0;
  bool _showImage = true;
  bool _statusPlay = true;
  bool isExpanded = false;
  bool isDirectorExpanded = false;
  bool isExpanded2 = false;
  bool isLoadingData = true;
  late MoviePresenter moviePr;
  late Movie _movieDetail;
  final ScrollController _scrollController = ScrollController();
  final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Styles.gradientTop[Config.themeMode]!,
      Styles.gradientBot[Config.themeMode]!
    ],
  );
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
  String textTitleAppbar = "Phim";
  String textDirector = "Đạo diễn";
  String textActor = "Diễn viên";
  String textDes = "Mô tả";
  String textShowTime = "Suất chiếu";
  String textInfo = "Thông tin";
  String textUpdate = "Đang cập nhật";
  String textLoad = "Đang tải";
  String textSeeMore = "Xem thêm";
  String textSummary = "Thu gọn";
  String textUpdateMovie = "Danh sách phim đang được cập nhật";

  late String name;
  void translate() async {
    List<String> translatedTexts = await Future.wait([
      Styles.translate(textTitleAppbar),
      Styles.translate(_movieDetail.name),
      Styles.translate(textDirector),
      Styles.translate(textActor),
      Styles.translate(textDes),
      Styles.translate(textShowTime),
      Styles.translate(textInfo),
      Styles.translate(_movieDetail.actor),
      Styles.translate(_movieDetail.description),
      Styles.translate(_movieDetail.director),
      Styles.translate(textUpdate),
      Styles.translate(textLoad),
      Styles.translate(textSeeMore),
      Styles.translate(textSummary),
      Styles.translate(textUpdateMovie),
    ]);
    textTitleAppbar = translatedTexts[0];
    _movieDetail.name = translatedTexts[1];
    textDirector = translatedTexts[2];
    textActor = translatedTexts[3];
    textDes = translatedTexts[4];
    textShowTime = translatedTexts[5];
    textInfo = translatedTexts[6];
    _movieDetail.actor = translatedTexts[7];
    _movieDetail.description = translatedTexts[8];
    _movieDetail.director = translatedTexts[9];
    textUpdate = translatedTexts[10];
    textLoad = translatedTexts[11];
    textSeeMore = translatedTexts[12];
    textSummary = translatedTexts[13];
    textUpdateMovie = translatedTexts[14];


    setState(() {});
  }

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

  void scroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
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
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var hS = MediaQuery.of(context).size.height;
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
            color: Styles.boldTextColor[Config.themeMode], // Màu bạn muốn
            onPressed: () {
              Navigator.pop(this.context);
            },
          ),
          title: Text(
            textTitleAppbar,
            style: TextStyle(
              fontSize: Styles.appbarFontSize,
              color: Styles.boldTextColor[Config.themeMode],
            ),
          ),
          backgroundColor: Styles.backgroundContent[Config.themeMode],
        ),
        backgroundColor: Styles.backgroundColor[Config.themeMode],
        body: Container(
          child: isLoadingData
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Styles.boldTextColor[Config.themeMode]!),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("$textLoad...",
                          style: TextStyle(
                            fontSize: Styles.titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Styles.boldTextColor[Config.themeMode],
                          ))
                    ],
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Phần xem trailer
                        Stack(
                          children: [
                            _showImage
                                ? SizedBox(
                                    width: wS,
                                    height: hS * 0.3,
                                    child: Image.network(
                                      "$serverUrl/Images/${_movieDetail.img}",
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/img/movie.png', // Đường dẫn đến ảnh mặc định từ assets
                                          fit: BoxFit.contain,
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(
                                    width: wS,
                                    height: hS / 3,
                                    child: WebViewWidget(
                                      controller: WebViewController()
                                        ..setJavaScriptMode(
                                            JavaScriptMode.unrestricted)
                                        ..setBackgroundColor(
                                            const Color(0x00000000))
                                        ..setNavigationDelegate(
                                          NavigationDelegate(
                                            onProgress: (int progress) {
                                              // Update loading bar.
                                            },
                                            onPageStarted: (String url) {},
                                            onPageFinished: (String url) {},
                                            onHttpError:
                                                (HttpResponseError error) {},
                                            onWebResourceError:
                                                (WebResourceError error) {},
                                            onNavigationRequest:
                                                (NavigationRequest request) {
                                              return NavigationDecision
                                                  .navigate;
                                            },
                                          ),
                                        )
                                        ..loadRequest(Uri.parse(
                                            'https://www.youtube.com/embed/${_movieDetail.trailer}')),
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
                                          color: Styles
                                              .boldTextColor[Config.themeMode],
                                        )
                                      : const Text(""),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${_movieDetail.name} (${_movieDetail.showTimeTypeName})',
                          style: TextStyle(
                              fontSize: Styles.titleFontSize,
                              color: Styles.boldTextColor[Config.themeMode]),
                        ),
                        //Phần chọn suất chiếu hoặc xem thông tin phim
                        Container(
                          width: wS - 30,
                          margin: const EdgeInsets.symmetric(
                              horizontal: Styles.defaultHorizontal),
                          child: ToggleButtons(
                            renderBorder: false,
                            fillColor: Colors.transparent,
                            onPressed: (int index) {
                              setState(() {
                                _selectedTabIndex = index;
                              });
                            },
                            isSelected: [
                              _selectedTabIndex == 0,
                              _selectedTabIndex == 1,
                            ],
                            children: [
                              Container(
                                width: (wS - 30) * 0.5,
                                padding: const EdgeInsets.all(5),
                                decoration: _selectedTabIndex == 0
                                    ? BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        gradient: gradient,
                                      )
                                    : BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        color:
                                            Styles.btnColor[Config.themeMode],
                                      ),
                                child: Text(
                                  textShowTime,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Styles.textSize,
                                    color: _selectedTabIndex != 0
                                        ? Styles
                                            .boldTextColor[Config.themeMode]
                                        : Styles.textSelectionColor[
                                            Config.themeMode],
                                  ),
                                ),
                              ),
                              Container(
                                width: (wS - 30) * 0.5 - 5,
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(left: 5),
                                decoration: _selectedTabIndex == 1
                                    ? BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        gradient: gradient,
                                      )
                                    : BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        color:
                                            Styles.btnColor[Config.themeMode],
                                      ),
                                child: Text(
                                  textInfo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Styles.textSize,
                                    color: _selectedTabIndex != 1
                                        ? Styles
                                            .boldTextColor[Config.themeMode]
                                        : Styles.textSelectionColor[
                                            Config.themeMode],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Phần chọn thông tin
                        if (_selectedTabIndex == 1)
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      "$serverUrl/Images/${_movieDetail.img}",
                                      fit: BoxFit.cover,
                                      height: 150,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/img/movie.png', // Đường dẫn đến ảnh mặc định từ assets
                                          fit: BoxFit.cover,
                                          height: 150,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _movieDetail.name,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Styles.boldTextColor[
                                                  Config.themeMode],
                                              fontSize: Styles.titleFontSize),
                                        ),
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
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            TimeBox(time: _movieDetail.time),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Styles.textColor[
                                                      Config.themeMode]!,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                _movieDetail.releaseDate),
                                            style: TextStyle(
                                              fontSize: Styles.textSize,
                                              color: Styles
                                                  .textColor[Config.themeMode],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        _movieDetail.movieType.isNotEmpty
                                            ? MovieTypeBox(
                                                padding: 5,
                                                title: _movieDetail.movieType,
                                              )
                                            : const SizedBox.shrink(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 1,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                color: const Color.fromARGB(255, 211, 211, 211),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: Styles.defaultHorizontal),
                                width: wS - 30,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title và danh sách đạo diễn
                                      TitleInfoMovie(title: textDirector),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Hiển thị danh sách đạo diễn
                                          ActorList(
                                              actors: _movieDetail.director),
                                        ],
                                      ),
                                      Container(
                                        height: 1,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        color: const Color.fromARGB(
                                            255, 211, 211, 211),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TitleInfoMovie(title: textActor),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ActorList(
                                                  actors: _movieDetail.actor),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 1,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        color: const Color.fromARGB(
                                            255, 211, 211, 211),
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TitleInfoMovie(title: textDes),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _movieDetail
                                                        .description.isNotEmpty
                                                    ? isExpanded
                                                        ? _movieDetail
                                                            .description
                                                        : '${_movieDetail.description.substring(0, 50)}...'
                                                    : textUpdate,
                                                style: TextStyle(
                                                    color: Styles.textColor[
                                                        Config.themeMode],
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
                                                      child: Text(
                                                       textSummary,
                                                        style: TextStyle(
                                                            color: Styles
                                                                    .textColor[
                                                                Config
                                                                    .themeMode],
                                                            fontSize: Styles
                                                                .textSize),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isExpanded = true;
                                                        });
                                                      },
                                                      child: Text(
                                                        textSeeMore,
                                                        style: TextStyle(
                                                            color: Styles
                                                                    .textColor[
                                                                Config
                                                                    .themeMode],
                                                            fontSize: Styles
                                                                .textSize),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        // Phần chọn suất chiếu
                        if (_selectedTabIndex == 0)
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                // color: Styles.backgroundContent[Config.themeMode],
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Styles.defaultHorizontal),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: days,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child:
                                    //danh sách showtime theo theater
                                    Column(
                                        children: schedule.theaters.isNotEmpty
                                            ? schedule.theaters
                                                .map((e) => ShowtimeFromTheater(
                                                    scroll: scroll,
                                                    selectedDate: selectedDate,
                                                    item: e,
                                                    movie: _movieDetail))
                                                .toList()
                                            : [
                                                Center(
                                                    child: Text(
                                                textUpdateMovie,
                                                  style: TextStyle(
                                                      color: Styles.textColor[
                                                          Config.themeMode],
                                                      fontSize:
                                                          Styles.textSize),
                                                ))
                                              ]),
                              )
                            ],
                          )
                        //phần schedules
                      ]),
                ),
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void onSearchComplete(Map<String, dynamic> results) {}
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
    translate();
  }

  @override
  void onLoadError() {
    setState(() {
      isLoadingData = false;
    });
  }

  @override
  void onLoadMoviesComplete(List<Movie> movies) {}
}
