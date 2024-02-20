/*import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favourite Movies"),
          backgroundColor: Colors.blue,
        ),
        body: GridView.builder(
          //shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: provider.titles.length,
          itemBuilder: (context, index) {
            final movie = provider.titles[index];
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
                          IconButton(
                              onPressed: () {
                                provider
                                    .toggleFavourite(movie.title);
                              },
                              icon: provider.isExist(movie.title)
                                  ? Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                              )
                                  : Icon(
                                Icons.favorite,
                                color: Colors.red,
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
*/

