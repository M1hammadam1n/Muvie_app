class TvShowRecommendations {
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;

  TvShowRecommendations({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvShowRecommendations.fromJson(Map<String, dynamic> json) {
    return TvShowRecommendations(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}
