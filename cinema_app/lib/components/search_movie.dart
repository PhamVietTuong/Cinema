import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/views/detail/movie_detail.dart';
import 'package:flutter/material.dart';

class SearchMovie extends SearchDelegate<String> {
  final List<Movie> movieList;
  SearchMovie(this.movieList);
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
    if (query.isEmpty) {
      return Container();
    }
    final suggestionList = movieList
        .where(
            (movie) => movie.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].name),
          onTap: () {
             Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetail(
              movieID: suggestionList[index].id,
              projectionForm: suggestionList[index].projectionForm,
            )),
        );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = movieList
        .where(
            (movie) => movie.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].name),
          onTap: () {
               Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetail(
              movieID: suggestionList[index].id,
              projectionForm: suggestionList[index].projectionForm,
            )),
        );
          },
        );
      },
    );
  }
}
