class MovieSearch {
  String title;
  String year;
  String id;

  MovieSearch({
    required this.title,
    required this.year,
    required this.id,
  });

  factory MovieSearch.fromJson(Map<String, dynamic> json) {
    return MovieSearch(
      title: json['title'],
      year: json['year'],
      id: json['imdb_id'],
    );
  }
}
