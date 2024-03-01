import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Data Storage and API Calls/apiKeys.dart';
import '../Data Storage and API Calls/movieDetails_provider.dart';
import '../Data Storage and API Calls/moviePosters_provider.dart';
import '../Data Storage and API Calls/movies_service.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({super.key});

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  MovieAPI movieAPI = MovieAPI(rapidApiKey: rapidApiKey);

  /*Movie movie = Movie(
      title: '',
      tagline: '',
      description: '',
      year: '',
      ageRating: '',
      ytKey: '');*/
  /*late Poster poster = Poster(poster: '', fanArt: '');*/
  /*List<Widget>? slideItems = [];*/
  /*bool isLoading = true;*/

  @override
  initState() {
    super.initState();
    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<IdProvider>(context,listen: false);
      final provider1 = Provider.of<MovieProvider>(context,listen: false);
      final provider2 = Provider.of<MoviePostersProvider>(context,listen: false);
      provider1.getMovieDetails(provider.id);
      provider2.getMoviePosters(provider.id);
    });*/
  }

  /*Future<void> _fetchMovieDetails(String id) async {
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
  }*/

  /*Future<void> _fetchPosters(String id) async {
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
  }*/

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
    final _data1 = ref.watch(MovieDetailsProvider);
    final _data2 = ref.watch(MoviePosterProvider);
    /*final provider1 = Provider.of<MovieProvider>(context);
    final provider2 = Provider.of<MoviePostersProvider>(context);*/
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.pop('/home'),
          ),
          title: _data1.when(
            data: (movieDetails) {
              return Text(movieDetails.title ?? "Null");
            },
            error: (e, st) {
              return Text("Error:$e");
            },
            loading: () => Text("Movie"),
          ),
        ),
        body: Container(
          height: size.height,
          child: SingleChildScrollView(
            child: _data1.when(
              data: (movieDetails) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _data2.when(
                        data: (posters) {
                          return Container(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 2.0,
                                enlargeCenterPage: true,
                                pageViewKey:
                                    PageStorageKey<String>('carousel_slider'),
                              ),
                              items: posters ??
                                  [
                                    Image(
                                      image: NetworkImage(
                                          'http://image.tmdb.org/t/p/original/jDdnDEGu3GiLtJwDXeL4hfFzmGv.jpg'),
                                    )
                                  ],
                            ),
                          );
                        },
                        error: (e, st) {
                          return Text("Error:$e");
                        },
                        loading: () {return Container(height: size.width/2,child: Text("Loading wait da"),);}
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text("Rating:"),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Tagline: ${movieDetails.tagline}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Year of Release: ${movieDetails.year ?? "Null"}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Age Rating: ${movieDetails.ageRating}",
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
                        movieDetails.description ?? "Null",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      InkWell(
                        onTap: () {
                          _launchInBrowser(Uri.parse(
                              "https://www.youtube.com/watch?v=${movieDetails.ytKey}" ??
                                  "https://www.youtube.com/"));
                        },
                        child: Text(
                          'Watch the trailer',
                          style: TextStyle(
                              color: Colors.blue, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (e, st) {
                return Text("Something went wrong:$e");
              },
              loading: () => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
