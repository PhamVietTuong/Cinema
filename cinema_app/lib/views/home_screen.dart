import 'package:cinema_app/components/info_movie.dart';
import 'package:cinema_app/components/slide_show.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/presenters/movie_presenter.dart';
import 'package:cinema_app/views/Account/account_screen.dart';
import 'package:cinema_app/views/Account/user_info_page.dart';
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
  String titleAppbar = "Xin chào!";
  String showing = "Đang chiếu";
  String trailer = "Đoạn phim giới thiệu";
  String early = "Chiếu sớm";
  String comming = "Sắp chiếu";
  String update = "Danh sách phim đang được cập nhật";
  String load = " Đang tải...";

  void translate() async {
    List<String> translatedTexts = await Future.wait([
      Styles.translate(titleAppbar),
      Styles.translate(showing),
      Styles.translate(trailer),
      Styles.translate(early),
      Styles.translate(comming),
      Styles.translate(update),
      Styles.translate(load),
    ]);
    titleAppbar = translatedTexts[0];
    showing = translatedTexts[1];
    trailer = translatedTexts[2];
    early = translatedTexts[3];
    comming = translatedTexts[4];
    update = translatedTexts[5];
    load = translatedTexts[6];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    moviePr = MoviePresenter(this);
    moviePr.fetchMovies();
    translate();
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var hS = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Config.userInfo != null
            ? Text(
                '$titleAppbar ${Config.userInfo!.fullname}',
                style: TextStyle(
                    color: Styles.boldTextColor[Config.themeMode],
                    fontSize: Styles.appbarFontSize),
              )
            : Text(
                titleAppbar,
                style: TextStyle(
                    color: Styles.boldTextColor[Config.themeMode],
                    fontSize: Styles.appbarFontSize),
              ),
        leading: Config.userInfo == null
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen()),
                  );
                },
                icon: const Icon(Icons.person_outlined),
                color: Styles.boldTextColor[Config.themeMode],
                iconSize: Styles.iconInAppBar,
              )
            : IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserInfoPage()),
                  );
                },
                icon: const Icon(Icons.person_outlined),
                color: Styles.boldTextColor[Config.themeMode],
                iconSize: Styles.iconInAppBar,
              ),
        backgroundColor: Styles.backgroundContent[Config.themeMode],
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(
              Icons.fastfood_outlined,
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
        decoration:
            BoxDecoration(color: Styles.backgroundColor[Config.themeMode]),
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
                      load,
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
                          width: wS,
                          height: hS / 3,
                          child: const SlideShow(),
                        ),
                        Container(
                          width: wS - 30,
                          margin: const EdgeInsets.symmetric(
                              horizontal: Styles.defaultHorizontal),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Styles.backgroundContent[Config.themeMode],
                          ),
                          child: ToggleButtons(
                            borderRadius: BorderRadius.circular(10),
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
                              _selectedTabIndex == 2,
                            ],
                            children: [
                              Container(
                                width: (wS - 30) * 0.33,
                                padding: const EdgeInsets.all(5),
                                decoration: _selectedTabIndex == 0
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: gradient,
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Styles.btnColor[Config.themeMode],
                                      ),
                                child: Text(
                                  showing,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Styles.textSize,
                                    color: _selectedTabIndex != 0
                                        ? Styles.boldTextColor[Config.themeMode]
                                        : Styles.textSelectionColor[
                                            Config.themeMode],
                                  ),
                                ),
                              ),
                              Container(
                                width: (wS - 30) * 0.33 - 4,
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                padding: const EdgeInsets.all(5),
                                decoration: _selectedTabIndex == 1
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: gradient,
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Styles.btnColor[Config.themeMode],
                                      ),
                                child: Text(
                                  early,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Styles.textSize,
                                    color: _selectedTabIndex != 1
                                        ? Styles.boldTextColor[Config.themeMode]
                                        : Styles.textSelectionColor[
                                            Config.themeMode],
                                  ),
                                ),
                              ),
                              Container(
                                width: (wS - 30) * 0.33,
                                padding: const EdgeInsets.all(5),
                                decoration: _selectedTabIndex == 2
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: gradient,
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Styles.btnColor[Config.themeMode],
                                      ),
                                child: Text(
                                  comming,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Styles.textSize,
                                    color: _selectedTabIndex != 2
                                        ? Styles.boldTextColor[Config.themeMode]
                                        : Styles.textSelectionColor[
                                            Config.themeMode],
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
                                                update,
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
                                                update,
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
                                                update,
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
                                trailer,
                                style: TextStyle(
                                    color:
                                        Styles.boldTextColor[Config.themeMode],
                                    fontSize: Styles.titleFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: hS / 3,
                                child: trailers.isNotEmpty
                                    ? PageView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: trailers.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                30,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
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
                                                    onPageStarted:
                                                        (String url) {},
                                                    onPageFinished:
                                                        (String url) {},
                                                    onHttpError:
                                                        (HttpResponseError
                                                            error) {},
                                                    onWebResourceError:
                                                        (WebResourceError
                                                            error) {},
                                                    onNavigationRequest:
                                                        (NavigationRequest
                                                            request) {
                                                      return NavigationDecision
                                                          .navigate;
                                                    },
                                                  ),
                                                )
                                                ..loadRequest(Uri.parse(
                                                    'https://www.youtube.com/embed/${trailers[index]}')),
                                            ),
                                          );
                                        },
                                      )
                                    : const SizedBox.shrink(),
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
  void onSearchComplete(Map<String, dynamic> results) {}
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
          .where((e) => e.releaseDate.isAfter(today) && !e.isSpecial)
          .toList();
      earlyMovies = movies.where((e) => e.isSpecial).toList();
      trailers = lstMovie
          .where((movie) => movie.trailer.isNotEmpty)
          .map((movie) => movie.trailer)
          .toSet()
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
