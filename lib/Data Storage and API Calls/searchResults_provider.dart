import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movies_service.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';

import 'apiKeys.dart';

final searchTitleProvider = StateProvider<String>((ref) => '');

final SearchResultProvider = FutureProvider<List<CurrentMovies>>((ref) async {
  final title = ref.watch(searchTitleProvider);

  try {
    return ref.watch(ApiCall).getSearchResults(title);
  } catch (error) {
    print('Error fetching movie list: $error');
    return [];
  }
});

final searchStateProvider = StateNotifierProvider<SearchProvider, List<CurrentMovies>>(
        (ref) => SearchProvider([CurrentMovies(title: "", year: "", id: "")]));

class SearchProvider extends StateNotifier<List<CurrentMovies>> {
  SearchProvider(super.state);

  final _service = MovieAPI(rapidApiKey: rapidApiKey);
  List<CurrentMovies> _searchResults = [];
  List<CurrentMovies> get searchResults => _searchResults;
  void set initmovies(List<dynamic> searchResults) => _searchResults;

  Future<void> getSearchResults(String title) async{
    final response = await _service.getSearchResults(title);
    _searchResults = response;
  }
}