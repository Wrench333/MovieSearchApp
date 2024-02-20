class Movie {
  String? title;
  String? tagline;
  String? description;
  String? year;
  String? ageRating;
  String? ytKey;

  Movie({
    required this.title,
    required this.tagline,
    required this.description,
    required this.year,
    required this.ageRating,
    required this.ytKey,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      tagline: json['tagline'],
      description: json['description'],
      year: json['year'],
      ageRating: json['rated'],
      ytKey: json['youtube_trailer_key'],
    );
  }
}
