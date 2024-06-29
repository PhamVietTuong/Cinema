import 'package:cinema_app/components/info_movie.dart';
import 'package:cinema_app/components/slide_show.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/presenters/movie_presenter.dart';
import 'package:cinema_app/views/search_movie.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements MovieViewContract {
  int _selectedTabIndex = 0;
  late MoviePresenter moviePr;
  final today = DateTime.now();
  bool isLoadingData = true;
  bool isSearching = false;
  final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Styles.gradientTop[Config.themeMode]!,
      Styles.gradientBot[Config.themeMode]!
    ],
  );
  List<Movie> lstMovie = List.filled(0, Movie(), growable: true);
  List<Movie> showingMovies = List.filled(0, Movie(), growable: true);
  List<Movie> upcomingMovies = List.filled(0, Movie(), growable: true);
  List<Movie> earlyMovies = List.filled(0, Movie(), growable: true);
  late List<String> trailers = [];

  @override
  void initState() {
    super.initState();
    moviePr = MoviePresenter(this);
    moviePr.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.backgroundContent[Config.themeMode],
        title: Text(
          "Xin Chào !",
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor[Config.themeMode],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              size: Styles.iconInAppBar,
            ),
            color: Styles.boldTextColor[Config.themeMode],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(
              Icons.search,
              size: Styles.iconInAppBar,
            ),
            color: Styles.boldTextColor[Config.themeMode],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Styles.backgroundColor[Config.themeMode]),
        child: Center(
          child: isLoadingData
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Styles.textColor[Config.themeMode]!),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Đang tải...",
                      style: TextStyle(
                          fontSize: Styles.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Styles.textColor[Config.themeMode]),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    color: Styles.backgroundColor[Config.themeMode],
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Styles.defaultHorizontal),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          child: const SlideShow(),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Styles.defaultHorizontal),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Styles.backgroundContent[Config.themeMode],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(10),
                                    selectedColor:
                                        Styles.boldTextColor[Config.themeMode],
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                20,
                                        margin: const EdgeInsets.only(right: 5),
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
                                                color: Styles
                                                    .btnColor[Config.themeMode],
                                              ),
                                        child: Text(
                                          "Đang chiếu",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: Styles.textSize,
                                            color: Styles
                                                .boldTextColor[Config.themeMode],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                20,
                                        margin: const EdgeInsets.only(right: 5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: _selectedTabIndex == 1
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: gradient,
                                              )
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Styles.primaryColor,
                                              ),
                                        child: Text(
                                          "Chiếu sớm",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Styles.textSize,
                                              color: Styles.boldTextColor[
                                                  Config.themeMode]),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                20,
                                        margin: const EdgeInsets.only(right: 5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: _selectedTabIndex == 2
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: gradient,
                                              )
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Styles.primaryColor,
                                              ),
                                        child: Text(
                                          "Sắp chiếu",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Styles.textSize,
                                              color: Styles.boldTextColor[
                                                  Config.themeMode]),
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
                                                style: TextStyle(
                                                    color: Styles.textColor[
                                                        Config.themeMode]),
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
                                                style: TextStyle(
                                                    color: Styles.textColor[
                                                        Config.themeMode]),
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
                                                style: TextStyle(
                                                    color: Styles.textColor[
                                                        Config.themeMode]),
                                              ),
                                            ],
                                    )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Styles.defaultHorizontal,
                              vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Video",
                                style: TextStyle(
                                    color: Styles.boldTextColor[Config.themeMode],
                                    fontSize: Styles.titleFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                child: trailers.isNotEmpty? PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: trailers.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: WebView(
                                        initialUrl:
                                            'https://www.youtube.com/embed/${trailers[index]}',
                                        javascriptMode:
                                            JavascriptMode.unrestricted,
                                      ),
                                    );
                                  },
                                ):SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void onSearchComplete(Map<String, dynamic> results) {
  }
  @override
  void onLoadMoviesComplete(List<Movie> movies) {
    setState(() {
      lstMovie = movies;
      showingMovies = movies
          .where((e) =>
              e.releaseDate.isBefore(today) ||
              (e.releaseDate.day == today.day &&
                  e.releaseDate.month == today.month))
          .toList();

      upcomingMovies = movies
          .where((e) =>
              e.releaseDate.isAfter(today) &&
              e.releaseDate.month == today.month)
          .toList();

      earlyMovies = movies
          .where((e) =>
              e.releaseDate.isAfter(today) &&
              e.releaseDate.difference(today).inDays < 7)
          .toList();

      trailers = showingMovies
          .where((movie) => movie.trailer.isNotEmpty)
          .map((movie) => movie.trailer)
          .toSet() // Lấy ra trailer của các phim
          .toList();
      isLoadingData = false;
      //print("$moviesWithTrailer");
    });
  }

  @override
  void onLoadMovieDetailComplete(Movie movies) {}

  @override
  void onLoadError() {
    setState(() {
      isLoadingData = false;
    });
  }
}
