import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movies_service.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';
import 'apiKeys.dart';

final MovieListProvider = FutureProvider<List<CurrentMovies>>((ref) async {
  return ref.watch(ApiCall).getCurrentMovies();
});

final currentStateProvider = StateNotifierProvider<CurrentMovieProvider, List<CurrentMovies>>(
        (ref) => CurrentMovieProvider([CurrentMovies(title: "", year: "", id: "")]));

class CurrentMovieProvider extends StateNotifier<List<CurrentMovies>> {
  CurrentMovieProvider(super.state);

  final _service = MovieAPI(rapidApiKey: rapidApiKey);
  List<CurrentMovies> _movies = [];
  List<CurrentMovies> get movies => _movies;

  Future<void> getMovieDetails() async{
    final response = await _service.getCurrentMovies();
    _movies = response;
  }
}