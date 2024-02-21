import 'package:flutter/cupertino.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';

class FavouriteProvider extends ChangeNotifier {
  static List<CurrentMovies> _favmovies = [];
  List<CurrentMovies> get favmovies => _favmovies;

  void toggleFavourite(CurrentMovies movie) {
    final isExist = _favmovies.contains(movie);
    print(isExist);
    if(isExist){
      _favmovies.remove(movie);
    } else {
      _favmovies.add(movie);
    }
    notifyListeners();
  }

  bool isExist(CurrentMovies movie) {
    final isExist = _favmovies.contains(movie);
    print(isExist);
    return isExist;
  }
}