import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/favourite_provider.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/loading_provider.dart';
import 'package:provider/provider.dart';
import '../Data Storage and API Calls/apiKeys.dart';
import '../Data Storage and API Calls/movies_service.dart';
import '../Models/currentMovies_model.dart';
import '../Models/movie_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  MovieAPI movieAPI = MovieAPI(
      rapidApiKey: rapidApiKey);
  List<CurrentMovies> nowShowing = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      var result = await movieAPI.getCurrentMovies();
      print('Current Movies List API Response: $result');
      nowShowing = result;
      print(nowShowing);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error in getting current movies: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error in getting "Now Showing" Movies: $e'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchSearchResults(String query) async {
    try {
      var result = await movieAPI.getSearchResults(query);
      print(
          'Movie Search API Response: $result'); //TODO: Assign result to another variable so that its accessible where needed
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
    final provider = Provider.of<IdProvider>(context);
    final provider2 = Provider.of<FavouriteProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Movie Browser"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: controller,
                onChanged: _fetchSearchResults,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(65, 105, 225, 1),
                  isDense: true,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              isLoading
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.grey),
                        ),
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        //shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: nowShowing.length,
                        itemBuilder: (context, index) {
                          final movie = nowShowing[index];
                          return Column(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    provider.idUpdate(movie.id);
                                    context.go('/details');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    height: 105,
                                    padding: const EdgeInsets.fromLTRB(
                                        23, 18, 8, 18),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          52, 152, 219, 0.8),
                                      borderRadius:
                                          BorderRadius.circular(17.36),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${movie.title}',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${movie.year}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '${movie.id}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  provider2
                                                      .toggleFavourite(movie.title);
                                                },
                                                icon: provider2.isExist(movie.title)
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.grey,
                                                      )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
        /*floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.go('/fav'),
          label: Text('Favourites'),
        ),*/
      ),
    );
  }
}
