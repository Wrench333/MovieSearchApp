import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';

final favouriteStateProvider = StateNotifierProvider<FavouriteProvider, List<CurrentMovies>>(
    (ref) => FavouriteProvider([CurrentMovies(title: "", year: "", id: "")]));

class FavouriteProvider extends StateNotifier<List<CurrentMovies>> {
  FavouriteProvider(super.state);

  static List<CurrentMovies> _favmovies = [];
  List<CurrentMovies> get favmovies => _favmovies;

  void toggleFavourite(CurrentMovies movie) {
    final isExist = _favmovies.contains(movie);
    print(isExist);
    if (isExist) {
      _favmovies.remove(movie);
    } else {
      _favmovies.add(movie);
    }
    state = List.from(_favmovies);
  }

  bool isExist(CurrentMovies movie) {
    final isExist = _favmovies.contains(movie);
    print(isExist);
    return isExist;
  }
}
