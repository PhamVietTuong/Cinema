import 'package:cinema_app/components/info_movie.dart';
import 'package:cinema_app/components/search_movie.dart';
import 'package:cinema_app/components/slide_show.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/presenters/movie_presenter.dart';
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
      Styles.gradientTop["dark_purple"]!,
      Styles.gradientBot["dark_purple"]!
    ],
  );
  List<Movie> lstMovie = List.filled(0, Movie(), growable: true);
  List<Movie> showingMovies = List.filled(0, Movie(), growable: true);
  List<Movie> upcomingMovies = List.filled(0, Movie(), growable: true);
  List<Movie> earlyMovies = List.filled(0, Movie(), growable: true);
  List<Movie> moviesWithTrailer = List.filled(0, Movie(), growable: true);

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
      moviesWithTrailer =
          // ignore: unnecessary_null_comparison
          showingMovies.where((movie) => movie.trailer != null).toList();
      isLoadingData = false;
      // print(" $moviesWithTrailer ");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.backgroundContent["dark_purple"],
        title: Text(
          "Xin Chào !",
          style: TextStyle(
              fontSize: Styles.appbarFontSize,
              color: Styles.boldTextColor["dark_purple"]),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Styles.btnColor["dark_purple"],
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
                Icons.notifications,
                size: Styles.iconInAppBar,
              ),
              color: Styles.boldTextColor["dark_purple"],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Styles.btnColor["dark_purple"],
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
              onPressed: () {
                setState(() {});
                showSearch(context: context, delegate: SearchMovie(lstMovie));
              },
              icon: Icon(Icons.search,
                  size: Styles.iconInAppBar,
                  color: Styles.boldTextColor["dark_purple"]),

            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Styles.backgroundColor["dark_purple"]),
        child: Center(
          child: isLoadingData
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Styles.textColor["dark_purple"]!),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Đang tải...",
                      style: TextStyle(
                          fontSize: Styles.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Styles.textColor["dark_purple"]),
                    )
                  ],
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    color: Styles.backgroundColor["dark_purple"],
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
                            color: Styles.backgroundContent["dark_purple"],
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
                                        Styles.boldTextColor["dark_purple"],
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
                                                    .btnColor["dark_purple"],
                                              ),
                                        child: Text(
                                          "Đang chiếu",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: Styles.textSize,
                                            color: Styles
                                                .boldTextColor["dark_purple"],
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
                                                color: const Color(0xFF802EF7),
                                              ),
                                        child: Text(
                                          "Chiếu sớm",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Styles.textSize,
                                              color: Styles.boldTextColor[
                                                  "dark_purple"]),
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
                                                color: const Color(0xFF802EF7),
                                              ),
                                        child: Text(
                                          "Sắp chiếu",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Styles.textSize,
                                              color: Styles.boldTextColor[
                                                  "dark_purple"]),
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
                                                        "dark_purple"]),
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
                                                        "dark_purple"]),
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
                                                        "dark_purple"]),
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
                                    color: Styles.boldTextColor["dark_purple"],
                                    fontSize: Styles.titleFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: moviesWithTrailer.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: WebView(
                                        initialUrl:
                                            'https://www.youtube.com/embed/${moviesWithTrailer[index].trailer}',
                                        javascriptMode:
                                            JavascriptMode.unrestricted,
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
        ),
      ),
    );
  }
}
