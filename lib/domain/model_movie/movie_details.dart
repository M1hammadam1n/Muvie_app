import 'package:json_annotation/json_annotation.dart';
import 'package:move_app_1/domain/model_movie/movie_date_parser.dart';
import 'package:move_app_1/domain/model_movie/movie_details_credits.dart';

part 'movie_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetails {
  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompanie> productionCompanies;
  final List<ProductionCountrie> productionCountries;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? releaseDate;
  final int revenue;
  final int? runtime;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final MovieDetailsCredits credits;
  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);


}


@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  final int id;
  final String name;
  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanie {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  ProductionCompanie({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanie.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanieFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanieToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountrie {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;
  ProductionCountrie({
    required this.iso,
    required this.name,
  });

  factory ProductionCountrie.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountrieFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountrieToJson(this);
}
