import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../Models/currentMovies_model.dart';
import '../Models/movieSearch_model.dart';
import '../Models/movie_model.dart';
import '../Models/poster_model.dart';
import 'apiKeys.dart';

final ApiCall = Provider<MovieAPI>((ref) => MovieAPI(rapidApiKey: rapidApiKey));

class MovieAPI {
  final String rapidApiKey;
  final String baseUrl = 'https://movies-tv-shows-database.p.rapidapi.com/';

  MovieAPI({required this.rapidApiKey});

  Future<List<CurrentMovies>> getCurrentMovies() async {
    // to get now playing movies for the home page
    try {
      final response = await http.get(
        Uri.parse(baseUrl + "?page=1"),
        headers: {
          "Type": "get-nowplaying-movies",
          "X-RapidAPI-Key": rapidApiKey,
          "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final length = data.length;
        print(length);
        List<CurrentMovies> currentMovies = [];
        for (int i = 0; i <
            length; i++) {
          currentMovies.add(CurrentMovies.fromJson(data, i));
        }
        print('Here is the response from the API: $data');
        return currentMovies;
      } else {
        throw Exception(
            'Failed to load movies list, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movies list: $e');
    }
  }

  Future<Movie> getMovieDetails(String id) async {
    // to get movie specific details to build its respective page
    try {
      final response =
      await http.get(Uri.parse(baseUrl + '?movieid=$id'), headers: {
        "Type": "get-movie-details",
        "X-RapidAPI-Key": rapidApiKey,
        "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com",
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Here is the response from the API: $data');
        return Movie.fromJson(data);
      } else {
        throw Exception(
            'Failed to load movies list, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movies list: $e');
    }
  }

  Future<List<CurrentMovies>> getSearchResults(String title) async {
    // to get movie specific details to build its respective page
    try {
      final response =
      await http.get(Uri.parse(baseUrl + '?title=$title'), headers: {
        "Type": "get-movies-by-title",
        "X-RapidAPI-Key": rapidApiKey,
        "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com",
        "Content-Type": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final length = data.length;
        print(length);
        List<CurrentMovies> searchResults = [];
        print('$data');
        for (int i = 0; i < length; i++) {
          searchResults.add(MovieSearch.fromJson(data, i).toCurrentMovies);
        }
        return searchResults;
      } else {
        throw Exception(
            'Failed to load search results, status code: ${response
                .statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load search results: $e');
    }
  }

  Future<Poster> getPosters(String id) async {
    // to get movie specific posters to build its respective page
    try {
      final response =
      await http.get(Uri.parse(baseUrl + '?movieid=$id'), headers: {
        "Type": "get-movies-images-by-imdb",
        "X-RapidAPI-Key": rapidApiKey,
        "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com",
        "Content-Type": "application/json;charset=UTF-8",
        'Charset': 'utf-8'
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final length = data.length;
        print('$data');
        return Poster.fromJson(data);
      } else {
        throw Exception(
            'Failed to load search results, status code: ${response
                .statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load search results: $e');
    }
  }
}
