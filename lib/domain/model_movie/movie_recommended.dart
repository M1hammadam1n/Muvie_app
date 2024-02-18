class MovieRecommendations {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;

  MovieRecommendations({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory MovieRecommendations.fromJson(Map<String, dynamic> json) {
    return MovieRecommendations(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}
