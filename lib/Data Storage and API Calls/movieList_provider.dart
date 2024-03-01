import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movies_service.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';
import 'apiKeys.dart';

final MovieListProvider = FutureProvider<List<CurrentMovies>>((ref) async {
  return ref.watch(ApiCall).getCurrentMovies();
});

/*class CurrentMovieProvider extends ChangeNotifier {
  final _service = MovieAPI(rapidApiKey: rapidApiKey);
  bool isLoading = false;
  List<dynamic> _movies = [];
  List<dynamic> get movies => _movies;

  Future<void> getMovieDetails() async{
    isLoading = true;
    notifyListeners();

    final response = await _service.getCurrentMovies();
    _movies = response;
    isLoading = false;
    notifyListeners();
  }
}*/