import 'package:flutter/cupertino.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movies_service.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';
import 'package:movie_search_app/Models/movieSearch_model.dart';
import 'apiKeys.dart';

class SearchProvider extends ChangeNotifier {
  final _service = MovieAPI(rapidApiKey: rapidApiKey);
  bool isLoading = false;
  List<dynamic> _searchResults = [];
  List<dynamic> get searchResults => _searchResults;
  void set initmovies(List<dynamic> searchResults) => _searchResults;

  Future<void> getSearchResults(String title) async{
    isLoading = true;
    notifyListeners();

    final response = await _service.getSearchResults(title);
    _searchResults = response;
    isLoading = false;
    notifyListeners();
  }
}