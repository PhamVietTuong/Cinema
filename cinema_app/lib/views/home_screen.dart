// ignore_for_file: avoid_print

import 'dart:async';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/presenters/movie_presenter.dart';
import 'package:cinema_app/views/detail/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements MovieViewContract {
  int _selectedTabIndex = 0;
  late MoviePresenter moviePr;
  var styles = Styles();
  final today = DateTime.now();
  bool isLoadingData = true;
  final gradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF802FF7), Color(0xFFB654C3)],
  );
  List<Movie> lstMovie = List.filled(0, Movie(), growable: true);
  List<Movie> showingMovies = List.filled(0, Movie(), growable: true);
  List<Movie> upcomingMovies = List.filled(0, Movie(), growable: true);
  List<Movie> earlyMovies = List.filled(0, Movie(), growable: true);

  @override
  void initState() {
    super.initState();
    moviePr = MoviePresenter(this);
    moviePr.fetchMovies();
  }

  @override
  void onLoadMoviesComplete(List<Movie> movies) {
    setState(() {
      lstMovie = movies;
      // Đoạn code ban đầu
      showingMovies = movies
          .where((e) =>
              e.releaseDate.day <= today.day &&
                  e.releaseDate.month == today.month ||
              e.releaseDate.month < today.month)
          .toList();
      upcomingMovies = movies
          .where((e) =>
              e.releaseDate.day > today.day &&
                  e.releaseDate.month == today.month ||
              e.releaseDate.month > today.month)
          .toList();

// Sửa lại và viết tiếp
      earlyMovies = movies
          .where((e) =>
              e.releaseDate.isAfter(today) &&
              e.releaseDate.difference(today).inDays < 7)
          .toList();

      isLoadingData = false;
      print(" $lstMovie");
    });
  }

  @override
  void onLoadMoviesError() {
    setState(() {
      isLoadingData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Xin Chào !",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF332E59),
        actions: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFF802EF7),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              color: Colors.white,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFF802EF7),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF272042),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: const SlideShow(),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF332E59),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ToggleButtons(
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: Colors.white,
                          fillColor: Colors.transparent,
                          borderWidth: 0,
                          onPressed: (int index) {
                            setState(() {
                              _selectedTabIndex = index;
                            });
                          },
                          isSelected: [
                            _selectedTabIndex == 0,
                            _selectedTabIndex == 1,
                            _selectedTabIndex == 2,
                          ],
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3 - 20,
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              padding: const EdgeInsets.all(5),
                              decoration: _selectedTabIndex == 0
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: gradient,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFF802EF7),
                                    ),
                              child: Text(
                                "Đang chiếu",
                                textAlign: TextAlign.center,
                                style: styles.titleTextStyle.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3 - 20,
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              padding: const EdgeInsets.all(5),
                              decoration: _selectedTabIndex == 1
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: gradient,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFF802EF7),
                                    ),
                              child: Text(
                                "Chiếu sớm",
                                textAlign: TextAlign.center,
                                style: styles.titleTextStyle.copyWith(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3 - 20,
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              padding: const EdgeInsets.all(5),
                              decoration: _selectedTabIndex == 2
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: gradient,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFF802EF7),
                                    ),
                              child: Text(
                                "Sắp chiếu",
                                textAlign: TextAlign.center,
                                style: styles.titleTextStyle.copyWith(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    if (_selectedTabIndex == 0)
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: showingMovies.isNotEmpty
                                ? showingMovies
                                    .map((e) => InfoMovie(movie: e))
                                    .toList()
                                : [
                                    Text(
                                      "Danh sách phim đang được cập nhật",
                                      style: styles.titleTextStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                          )),
                    if (_selectedTabIndex == 1)
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: earlyMovies.isNotEmpty
                                ? earlyMovies
                                    .map((e) => InfoMovie(movie: e))
                                    .toList()
                                : [
                                    Text(
                                      "Danh sách phim đang được cập nhật",
                                      style: styles.titleTextStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                          )),
                    if (_selectedTabIndex == 2)
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: upcomingMovies.isNotEmpty
                                ? upcomingMovies
                                    .map((e) => InfoMovie(movie: e))
                                    .toList()
                                : [
                                    Text(
                                      "Danh sách phim đang được cập nhật",
                                      style: styles.titleTextStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                          )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Video",
                        style: styles.titleTextStyle
                            .copyWith(color: Colors.white)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lstMovie.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width - 30,
                            height: MediaQuery.of(context).size.height / 3,
                            child: WebView(
                              initialUrl:
                                  'https://www.youtube.com/embed/${lstMovie[index].trailer}',
                              javascriptMode: JavascriptMode.unrestricted,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Slide Show
class SlideShow extends StatefulWidget {
  const SlideShow({super.key});

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Khởi tạo một Timer để tự động chuyển đổi giữa các trang của carousel.
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      // Nếu trang hiện tại nhỏ hơn 2 (chỉ số của trang cuối cùng trong carousel),
      if (_currentPage < 2) {
        // Tăng chỉ số của trang hiện tại lên một đơn vị.
        _currentPage++;
      } else {
        // Nếu trang hiện tại là trang cuối cùng, đặt lại chỉ số của trang hiện tại về 0 (trang đầu tiên).
        _currentPage = 0;
      }
      // Sử dụng _pageController để chuyển đến trang mới được xác định bởi _currentPage.
      _pageController.animateToPage(
        _currentPage, // Chỉ số của trang mới
        duration: const Duration(milliseconds: 500), // Thời gian chuyển đổi
        curve: Curves.ease, // Kiểu chuyển đổi
      );
    });
  }

// Hàm được gọi khi widget bị xóa khỏi cây widget
  @override
  void dispose() {
    // Hủy bỏ Timer để tránh rò rỉ bộ nhớ.
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (int page) {
        setState(() {
          _currentPage = page;
        });
      },
      children: [
        Center(
          child: ClipRRect(
            child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        ),
      ],
    );
  }
}

//info Movie
// ignore: must_be_immutable
class InfoMovie extends StatelessWidget {
  InfoMovie({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  var styles = Styles();

  @override
  Widget build(BuildContext context) {
    var wImage = (MediaQuery.of(context).size.width - 30) / 2;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetail(
                    movie: movie,
                  )),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: wImage,
            height: wImage / 0.57,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage("$serverUrl/Images/${movie.img}"),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                movie.ageRestrictionName.isNotEmpty
                    ? AgeRestrictionBox(
                        title: movie.ageRestrictionName,
                        fontSizeCus: 14,
                      )
                    : const SizedBox.shrink(),
                movie.showTimeTypeName.isEmpty
                    ? const SizedBox.shrink()
                    : ShowtimeTypeBox(
                        title: movie.showTimeTypeName,
                        fontSizeCus: 14,
                      )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.name,
            style: styles.titleTextStyle.copyWith(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
