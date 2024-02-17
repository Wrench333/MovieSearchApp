import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/currentMovies_model.dart';
import '../Models/movie_model.dart';
//import './apiKey.txt';

class MovieAPI {
  final String rapidApiKey;
  final String baseUrl = 'https://movies-tv-shows-database.p.rapidapi.com/';

  MovieAPI({required this.rapidApiKey});

  Future<Curr_Movies> getCurrentMovies(int i) async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl + "?page=1"),
        headers: {
          "Type": "get-nowplaying-movies",
          "X-RapidAPI-Key": rapidApiKey,
          "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com",
          "Content-Type": "application/json",
        },);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final length = data.length;
        print('$data');
        return Curr_Movies.fromJson(data, i);
      } else {
        throw Exception(
            'Failed to load movies list, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movies list: $e');
    }
  }

  Future<Movie> getMovieDetails(String id) async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl + '?movieid=$id'),headers: {
        "Type": "get-movie-details",
        "X-RapidAPI-Key": rapidApiKey,
        "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com",
        "Content-Type": "application/json",
      }); //TODO: Update this with the correct URL

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final length = data.length;
        print('$data');
        return Movie.fromJson(data);
      } else {
        throw Exception(
            'Failed to load movie details, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}