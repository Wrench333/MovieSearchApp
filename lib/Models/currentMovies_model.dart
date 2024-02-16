class Curr_Movies {
  String title;
  String year;
  String id;

  Curr_Movies({
    required this.title,
    required this.year,
    required this.id,
  });

  factory Curr_Movies.fromJson(Map<String, dynamic> json, int i) {
    return Curr_Movies(
      title: json['movie_results'][i]['title'],
      year: json['movie_results'][i]['year'],
      id: json['movie_results'][i]['id'],
    );
  }
}
