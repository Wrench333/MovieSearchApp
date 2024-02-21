import 'package:flutter/cupertino.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movies_service.dart';

import '../Models/movie_model.dart';
import 'apiKeys.dart';

class MovieProvider extends ChangeNotifier {
  final _service = MovieAPI(rapidApiKey: rapidApiKey);
  bool isLoading = false;
  Movie _movieDetails = Movie(title: '', tagline: '', description: '', year: '', ageRating: '', ytKey: '');
  Movie get movieDetails => _movieDetails;

  Future<void> getMovieDetails(String id) async{
    isLoading = true;
    notifyListeners();

    final response = await _service.getMovieDetails(id);

    _movieDetails = response;
    isLoading = false;
    notifyListeners();
  }
}