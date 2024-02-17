class MovieSearch {
  String title;
  int year;
  String id;

  MovieSearch({
    required this.title,
    required this.year,
    required this.id,
  });

  factory MovieSearch.fromJson(Map<String, dynamic> json,int i) {
    return MovieSearch(
      title: json['movie_results'][i]['title'],
      year: json['movie_results'][i]['year'],
      id: json['movie_results'][i]['imdb_id'],
    );
  }
}
