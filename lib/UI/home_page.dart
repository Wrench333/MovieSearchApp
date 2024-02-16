import 'package:flutter/material.dart';
import '../Data Storage and API Calls/movies_service.dart';
import '../Models/currentMovies_model.dart';

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
        print('Course List API Response: $result');
        nowShowing.add(result);
      }
      print(nowShowing);
    } catch (e) {
      print('Error in getting course list: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error in getting "Now Showing" Movies: $e'),
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
