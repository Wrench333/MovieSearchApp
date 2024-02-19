class Poster {
  String poster;
  String fanArt;

  Poster({
    required this.poster,
    required this.fanArt,
  });

  factory Poster.fromJson(Map<String, dynamic> json) {
    return Poster(
      poster: json['poster'],
      fanArt: json['fanart'],
    );
  }
}
