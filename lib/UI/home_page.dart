import 'package:flutter/material.dart';
import '../Data Storage and API Calls/movies_service.dart';
import '../Models/currentMovies_model.dart';
import '../Models/movie_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieAPI movieAPI = MovieAPI(rapidApiKey:'5b203ffa19mshbf72831f459dca4p18370djsnbb14873555e8');
  List<Curr_Movies> nowShowing = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      for (int i = 0; i < 20; i++) { //TODO: Make this dynamic with movieAPI.length using provider
        var result = await movieAPI.getCurrentMovies(i);
        print('Current Movies List API Response: $result');
        nowShowing.add(result);
      }
      print(nowShowing);
    } catch (e) {
      print('Error in getting current movies: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error in getting "Now Showing" Movies: $e'),
        ),
      );
    }
  }

  Future<void> _fetchMovieDetails(String id) async {
    try {
        var result = await movieAPI.getMovieDetails(id);
        print('Movie Details API Response: $result'); //TODO: Assign result to another variable so that its accessible where needed
    } catch (e) {
      print('Error in getting movie details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error in getting Movie details: $e'),
        ),
      );
    }
  }

  Future<void> _fetchSearchResults(String query) async {
    try {
      var result = await movieAPI.getSearchResults(query);
      print('Movie Search API Response: $result'); //TODO: Assign result to another variable so that its accessible where needed
    } catch (e) {
      print('Error in getting search results: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error in getting search results: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title:Text("Movie Browser"),backgroundColor: Colors.blue,),
        body: Container(),
      ),
    );
  }
}
