import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Data Storage and API Calls/apiKeys.dart';
import '../Data Storage and API Calls/loading_provider.dart';
import '../Data Storage and API Calls/movies_service.dart';
import '../Models/movie_model.dart';
import '../Models/poster_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  MovieAPI movieAPI = MovieAPI(
      rapidApiKey: rapidApiKey);
  Movie movie = Movie(
      title: '',
      tagline: '',
      description: '',
      year: '',
      ageRating: '',
      ytKey: '');
  late Poster poster = Poster(poster: '', fanArt: '');
  List<Widget>? slideItems = [];
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<IdProvider>(context,listen: false);
      _fetchMovieDetails(provider.id);
      _fetchPosters(provider.id);
    });
  }

  Future<void> _fetchMovieDetails(String id) async {
    try {
      var result = await movieAPI.getMovieDetails(id);
      print('Movie Details API Response: $result');
      setState(() {
        movie = result;
        isLoading = false;
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
        isLoading = false;
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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<IdProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.go('/home'),
          ),
          title: Text(movie.title?? "Null"),
        ),
        body: SingleChildScrollView(
          child: isLoading
              ? Container(
                  height: size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            pageViewKey:
                                PageStorageKey<String>('carousel_slider'),
                          ),
                          items: slideItems,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(children: [
                        Text("Rating:"),
                        Icon(Icons.star,color: Colors.yellow,),
                        Icon(Icons.star,color: Colors.yellow,),
                        Icon(Icons.star,color: Colors.yellow,),
                        Icon(Icons.star,color: Colors.yellow,),
                        Icon(Icons.star,color: Colors.yellow,),
                      ],),
                      SizedBox(height: 8.0,),
                      Text(
                        "Tagline: ${movie.tagline}", //TODO: Make this id dynamic
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        "Year of Release: ${movie.year ?? "Null"}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Movie ID: ${provider.id}", //TODO: Make this id dynamic
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        ),
                      SizedBox(height: 8.0),
                      Text(
                        movie.description ?? "Null",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchInBrowser(Uri.parse(
                              "https://www.youtube.com/watch?v=${movie.ytKey}" ?? "https://www.youtube.com/"));
                        },
                        child: Text(
                          'Watch the trailer',
                          style: TextStyle(
                              color: Colors.blue, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
