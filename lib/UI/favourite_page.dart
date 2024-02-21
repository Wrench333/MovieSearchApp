import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/favourite_provider.dart';
import 'package:provider/provider.dart';
import '../Data Storage and API Calls/loading_provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    final provider2 =  Provider.of<IdProvider>(context);
    final favmovies = provider.favmovies;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed:() => context.go('/home'),icon: Icon(Icons.arrow_back_ios_new),),
          title: Text("Favourite Movies"),
          backgroundColor: Colors.red,
        ),
        body: GridView.builder(
          //shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: favmovies.length,
          itemBuilder: (context, index) {
            final movie = favmovies[index];
            return Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      provider2.idUpdate(movie.id);
                      context.go('/details');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,vertical: 20),
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
                          IconButton(
                              onPressed: () {
                                provider
                                    .toggleFavourite(movie);
                              },
                              icon: provider.isExist(movie)
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
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

