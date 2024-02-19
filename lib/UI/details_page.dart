import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movies_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/movie_model.dart';
import '../Models/poster_model.dart'; // Assuming you have a widget for carousel slider

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  MovieAPI movieAPI = MovieAPI(
      rapidApiKey: '5b203ffa19mshbf72831f459dca4p18370djsnbb14873555e8');
  Movie movie = Movie(
      title: '',
      tagline: '',
      description: '',
      year: '',
      ageRating: '',
      ytKey: '');
  late Poster poster = Poster(poster: '', fanArt: '');
  List<Widget>? slideItems = [];

  @override
  initState() {
    super.initState();
    _fetchMovieDetails('tt1375666'); //TODO: Make the id dynamic
    _fetchPosters('tt1375666'); //TODO: Make the id dynamic
  }

  Future<void> _fetchMovieDetails(String id) async {
    try {
      var result = await movieAPI.getMovieDetails(id);
      print('Movie Details API Response: $result');
      setState(() {
        movie = result;
      });
    } catch (e) {
      print('Error in getting movie details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error in getting Movie details: $e'),
        ),
      );
    }
  }

  Future<void> _fetchPosters(String id) async {
    try {
      var result = await movieAPI.getPosters(id);
      print('Movie Details API Response: $result');
      setState(() {
        poster = result;
        slideItems = [
          Image.network(poster.poster),
          Image.network(poster.fanArt)
        ];
      });
    } catch (e) {
      print('Error in getting movie posters: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error in getting Movie posters: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.go('/home'),
        ),
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        pageViewKey: PageStorageKey<String>('carousel_slider'),
                      ),
                      items: slideItems,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Year of Release: ${movie.year}",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Movie ID: id", //TODO: Make this id dynamic
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    movie.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  InkWell(
                    onTap: () => launchUrl(Uri.parse(movie.ytKey)),
                    child: Text(
                      'Watch the trailer',
                      style: TextStyle(
                          color: Colors.blue, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
