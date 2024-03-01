import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/movies_service.dart';

final searchTitleProvider = StateProvider<String>((ref) => '');

final MovieListProvider = FutureProvider<List<dynamic>>((ref) async {
  final title = ref.watch(searchTitleProvider);

  try {
    final searchResults = await ref.watch(ApiCall).getSearchResults(title);
    return searchResults;
  } catch (error) {
    // Handle the error, e.g., log it or show an error message
    print('Error fetching movie list: $error');
    return [];
  }
});

/*class SearchProvider extends ChangeNotifier {
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
}*/