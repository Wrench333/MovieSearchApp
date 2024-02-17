class CurrentMovies {
  String title;
  String year;
  String id;

  CurrentMovies({
    required this.title,
    required this.year,
    required this.id,
  });

  factory CurrentMovies.fromJson(Map<String, dynamic> json, int i) {
    return CurrentMovies(
      title: json['movie_results'][i]['title'],
      year: json['movie_results'][i]['year'],
      id: json['movie_results'][i]['imdb_id'],
    );
  }
}
