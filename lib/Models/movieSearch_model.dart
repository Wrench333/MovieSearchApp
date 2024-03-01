import 'package:flutter/cupertino.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';
import 'package:movie_search_app/Models/movie_model.dart';

class MovieSearch {
  String title;
  String year;
  String id;

  MovieSearch({
    required this.title,
    required this.year,
    required this.id,
  });

  factory MovieSearch.fromJson(Map<String, dynamic> json,int i) {
    return MovieSearch(
      title: json['movie_results'][i]['title'],
      year: json['movie_results'][i]['year'].toString(),
      id: json['movie_results'][i]['imdb_id'],
    );
  }
}

extension MovieSearchExtension on MovieSearch{
  CurrentMovies get toCurrentMovies => CurrentMovies(title: this.title, year: this.year, id: this.id);
}