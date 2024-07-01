import 'package:cinema_app/data/models/theater.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/booking.dart';
import 'package:cinema_app/presenters/movie_presenter.dart';
import 'package:cinema_app/views/2_showtime_selection/showtime_screen.dart';
import 'package:cinema_app/views/detail/movie_detail.dart';
import 'package:cinema_app/data/models/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    implements MovieViewContract {
  TextEditingController _controller = TextEditingController();
  MoviePresenter? _presenter;
  Map<String, dynamic>? _searchResults;
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _presenter = MoviePresenter(this);
    _loadSearchHistory();
  }

  void _search() {
    String name = _controller.text.trim();
    if (name.isNotEmpty) {
      _presenter?.searchByName(name);
    } else {
      setState(() {
        _searchResults = null;
      });
    }
  }

  Future<void> _loadSearchHistory() async {
    List<String> history = await Config.loadSearchHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  Future<void> _saveSearchQuery(String query) async {
    await Config.saveSearchQuery(query);
    _loadSearchHistory();
  }

  Future<void> _clearSearchHistory() async {
    await Config.clearSearchHistory();
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  void onLoadMoviesComplete(List<Movie> movies) {}

  @override
  void onLoadMovieDetailComplete(Movie movie) {}

  @override
  void onSearchComplete(Map<String, dynamic> results) {
    setState(() {
      _searchResults = results;
    });
  }

  @override
  void onLoadError() {
    setState(() {
      _searchResults = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.backgroundContent["dark_purple"],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Styles.boldTextColor["dark_purple"],
          onPressed: () {
            Navigator.pop(this.context);
          },
        ),
        title: Text(
          "Tìm kiếm",
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor["dark_purple"],
          ),
        ),
      ),
      backgroundColor: Styles.backgroundColor["dark_purple"],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Styles.defaultHorizontal, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                onChanged: (value) {
                  _search();
                },
                style: TextStyle(
                  color: _controller.text.isNotEmpty
                      ? Styles.textColor["dark_purple"]
                      : Colors.white,
                  fontSize: Styles.textSize,
                ),
                decoration: InputDecoration(
                  labelText: 'Nhập từ khóa',
                  labelStyle: TextStyle(color: Styles.textColor["dark_purple"]),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Styles.textColor["dark_purple"],
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              _search();
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Styles.textColor["dark_purple"],
                          ),
                          onPressed: () {
                            setState(() {
                              _search();
                            });
                          },
                        ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.textColor["dark_purple"]!),
                    borderRadius:
                        BorderRadius.circular(10.0), // Độ bo tròn các góc
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.textColor["dark_purple"]!),
                    borderRadius:
                        BorderRadius.circular(10.0), // Độ bo tròn các góc
                  ),
                ),
              ),
              const SizedBox(height: 5), // Khoảng cách giữa các phần tử
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lịch sử tìm kiếm',
                        style: TextStyle(
                          fontSize: Styles.titleFontSize,
                          color: Styles.titleColor["dark_purple"]!,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _clearSearchHistory();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5), // Khoảng cách giữa tiêu đề và nút xóa
                  Column(
                    children: _buildSearchHistory(),
                  ),
                ],
              ),
              SizedBox(
                  height:
                      5), // Khoảng cách giữa lịch sử tìm kiếm và kết quả tìm kiếm
              _searchResults != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildSearchResults(),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSearchResults() {
    List<Widget> results = [];
    if (_searchResults!.containsKey('theaters')) {
      results.add(
        Text(
          'Danh sách các rạp chiếu',
          style: TextStyle(
            fontSize: Styles.titleFontSize,
            color: Styles.titleColor["dark_purple"]!,
          ),
        ),
      );
      for (var theaterData in _searchResults!['theaters']) {
        Theater theater = Theater.fromJson(theaterData);
        results.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowTimeSceen(
                    booking: Booking(theater: theater),
                  ),
                ),
              );
              _saveSearchQuery(theater.name);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Styles.backgroundContent["dark_purple"],
                borderRadius: BorderRadius.circular(5),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    theater.name,
                    style: TextStyle(
                      fontSize: Styles.textSize,
                      color: Styles.boldTextColor["dark_purple"]!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    if (_searchResults!.containsKey('movies')) {
      results.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            'Danh sách phim',
            style: TextStyle(
              fontSize: Styles.titleFontSize,
              color: Styles.titleColor["dark_purple"]!,
            ),
          ),
        ),
      );
      for (var movie in _searchResults!['movies']) {
        results.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetail(
                    movieID: movie['id'],
                    projectionForm: movie['projectionForm'],
                  ),
                ),
              );
              _saveSearchQuery(movie['name']);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Styles.backgroundContent["dark_purple"],
                borderRadius: BorderRadius.circular(5),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movie['name']}(${movie['showTimeTypeName']})',
                    style: TextStyle(
                      fontSize: Styles.textSize,
                      color: Styles.boldTextColor["dark_purple"]!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return results;
  }

  List<Widget> _buildSearchHistory() {
    return _searchHistory.map((query) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _controller.text = query;
                setState(() {
                  _search();
                });
              },
              child: Text(
                query,
                style: TextStyle(
                  fontSize: Styles.textSize,
                  color: Styles.boldTextColor["dark_purple"]!,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () async {
              await Config.removeSearchQuery(
                  query);
              await _loadSearchHistory();
            },
          ),
        ],
      );
    }).toList();
  }
}
