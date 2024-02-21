import 'package:flutter/cupertino.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movies_service.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';
import 'package:movie_search_app/Models/poster_model.dart';
import 'apiKeys.dart';

class MoviePostersProvider extends ChangeNotifier {
  final _service = MovieAPI(rapidApiKey: rapidApiKey);
  bool isLoading = false;
  List<Widget>? _posters = [];
  List<Widget>? get posters => _posters;

  Future<void> getMoviePosters(String id) async{
    isLoading = true;
    notifyListeners();

    final response = await _service.getPosters(id);
    _posters = [
      Image.network(response.poster),
      Image.network(response.fanArt),
    ];
    print(_posters);
    isLoading = false;
    notifyListeners();
  }
}