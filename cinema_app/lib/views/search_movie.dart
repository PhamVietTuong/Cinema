import 'dart:async';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/views/detail/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchMovie extends SearchDelegate<String> {
  final List<Movie> movieList;
  late List<String> searchHistory;

  SearchMovie(this.movieList) {
    loadSearchHistory();
  }

  Future<void> loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchHistory = prefs.getStringList('searchHistory') ?? [];
  }

  Future<void> saveSearchHistory(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
      await prefs.setStringList('searchHistory', searchHistory);
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? searchHistory.reversed.toList()
        : movieList
            .where(
              (movie) => movie.name.toLowerCase().contains(query.toLowerCase()),
            )
            .map((movie) => movie.name)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Lịch sử tìm kiếm',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(suggestionList[index]),
              onTap: () {
                query = suggestionList[index];
                showResults(context);
              },
            );
          },
        ),
      ],
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    final resultList = movieList
        .where((movie) =>
            movie.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: resultList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(resultList[index].name),
          onTap: () {
            saveSearchHistory(query); // Save the search query to history
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetail(
                  movieID: resultList[index].id,
                  projectionForm: resultList[index].projectionForm,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    saveSearchHistory(query); // Save the search query to history
    super.showResults(context);
  }

  @override
  void showSuggestions(BuildContext context) {
    saveSearchHistory(query); // Save the search query to history
    super.showSuggestions(context);
  }
}
