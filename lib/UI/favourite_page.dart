import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/favourite_provider.dart';
import 'package:movie_search_app/main.dart';
import 'package:provider/provider.dart';
import '../Data Storage and API Calls/loading_provider.dart';

class FavouritePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final favmovies = ref.watch(favouriteStateProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed:() => context.pop('/home'),icon: Icon(Icons.arrow_back_ios_new),),
          title: Text("Favourite Movies"),
          backgroundColor: Colors.red,
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: GridView.builder(
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
                        ref.read(idStateProvider.notifier).state = movie.id ;
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
                                  ref
                                      .read(
                                      favouriteStateProvider
                                          .notifier)
                                      .toggleFavourite(movie);
                                },
                                icon: favmovies.contains(movie)
                                    ? Icon(
                                  Icons.favorite,
                                  color: Color.fromRGBO(202, 247, 226,1),
                                )
                                    : Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                ),
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
      ),
    );
  }
}

