  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:go_router/go_router.dart';
  import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/google_sign_in.dart';
  import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movieList_provider.dart';
  import 'package:movie_search_app/main.dart';
  import '../Data Storage and API Calls/apiKeys.dart';
  import '../Data Storage and API Calls/movies_service.dart';

  class HomePage extends ConsumerStatefulWidget {
    const HomePage({super.key});

    @override
    ConsumerState<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends ConsumerState<HomePage> {
    final controller = TextEditingController();
    MovieAPI movieAPI = MovieAPI(rapidApiKey: rapidApiKey);

    @override
    void initState() {
      super.initState();
      /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final provider = Provider.of<CurrentMovieProvider>(context,listen: false);
        provider.getMovieDetails();
      });*/
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
      Size size = MediaQuery.of(context).size;
      final user = FirebaseAuth.instance.currentUser;
      final _data = ref.watch(MovieListProvider);
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Current User Details"),
                        content: Text(
                            "Name: ${user.displayName}\nEmail: ${user.email}\n Ph No:${user.phoneNumber ?? 1234567890}"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(user!.photoURL!),
                ),
              ),
            ),
            title: Center(
                child: Text(
              "Movie Browser",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 33.0,
                  fontWeight: FontWeight.bold),
            )),
            actions: [
              IconButton(icon:Icon(Icons.logout,size: 30,),onPressed: () {
                ref.watch(googleSignOutProvider);
              },)
            ],
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
                    /*provider3.getSearchResults(query);
                    suggestions = provider3.searchResults;*/
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
                SizedBox(
                  height: 8.0,
                ),
                _data.when(
                    data: (movies) {
                      return Expanded(
                        child: GridView.builder(
                          //shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      ref.read(idStateProvider.notifier).state =
                                          movie.id;
                                      context.push('/details');
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      height: size.height / 2,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8.0),
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
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    final isExist =
                                                    ref
                                                        .read(
                                                        favouriteStateProvider)
                                                        .contains(movie);
                                                    print(isExist);
                                                    if (isExist) {
                                                      ref.read(
                                                          favouriteStateProvider.notifier).state.remove(movie);
                                                    } else {
                                                      ref.read(
                                                          favouriteStateProvider.notifier).state.add(movie);
                                                    }
                                                  },
                                                  icon: ref
                                                          .watch(
                                                              favouriteStateProvider)
                                                          .contains(movie)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: Color.fromRGBO(
                                                              202, 247, 226, 1),
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
                      );
                    },
                    error: (e, st) {
                      return Center(child: Text("There was an error $e"));
                    },
                    loading: () => Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.grey),
                            ),
                          ),
                        )),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/fav'),
            label: Icon(
              Icons.favorite,
              color: Color.fromRGBO(202, 247, 226, 1),
            ),
            backgroundColor: Colors.red,
          ),
        ),
      );
    }
  }
