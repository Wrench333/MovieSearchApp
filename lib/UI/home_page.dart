import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/favourite_provider.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/loading_provider.dart';
import 'package:provider/provider.dart';
import '../Data Storage and API Calls/apiKeys.dart';
import '../Data Storage and API Calls/movieList_provider.dart';
import '../Data Storage and API Calls/movies_service.dart';
import '../Data Storage and API Calls/searchResults_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  MovieAPI movieAPI = MovieAPI(
      rapidApiKey: rapidApiKey);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<CurrentMovieProvider>(context,listen: false);
      provider.getMovieDetails();
    });
  }

  /*Future<void> _fetchMovies() async {
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
  }*/

  Future<void> _fetchSearchResults(String query) async {
    try {
      var result = await movieAPI.getSearchResults(query);
      print(
          'Movie Search API Response: $result');//TODO: Assign result to another variable so that its accessible where needed
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
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<IdProvider>(context);
    final provider1 = Provider.of<CurrentMovieProvider>(context);
    final provider2 = Provider.of<FavouriteProvider>(context);
    final provider3 = Provider.of<SearchProvider>(context);
    var suggestions = provider1.movies;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text("Movie Browser",style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold),)),
          backgroundColor: Colors.red.withOpacity(1),
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
                onChanged: (query) {
                  provider3.getSearchResults(query);
                  suggestions = provider3.searchResults;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              SizedBox(height: 8.0,),
              provider1.isLoading
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
                        itemCount: provider1.movies.length,
                        itemBuilder: (context, index) {
                          final movie = provider1.movies[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    provider.idUpdate(movie.id);
                                    context.push('/details');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    height: size.height/2,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
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
                                            fontSize: 22.0,
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
                                                      .toggleFavourite(movie);
                                                },
                                                icon: provider2.isExist(movie)
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: Color.fromRGBO(202, 247, 226,1),
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push('/fav'),
          label: Icon(Icons.favorite,color: Color.fromRGBO(202, 247, 226,1),),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
