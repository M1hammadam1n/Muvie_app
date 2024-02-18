import 'package:json_annotation/json_annotation.dart';
import 'package:move_app_1/domain/model_movie/movie_date_parser.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show_details_credits.dart';
part 'tv_show_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowDetails {
  final bool adult;
  final String? backdropPath;
  final List<int>? episodeRunTime;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? firstAirDate;
  final List<Genre> genres;
  final List<CreatedBy>? createdBy;
  final String homepage;
  final int id;
  final bool? inProduction;
  final List<String> languages;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? lastAirDate;
  final String  name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String? overview;
  final double popularity;
  final String posterPath;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double  voteAverage;
  final int voteCount;
  final TvShowDetailsCredits? credits;
  final int? episodeCount;
  final int? seasonNumber;
  final int? runtime;

  TvShowDetails({
    required this.runtime,
    required this.seasonNumber,
    required this.episodeCount,
    required this.adult,
    required this.createdBy,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
  });

  factory TvShowDetails.fromJson(Map<String, dynamic> json) =>
      _$TvShowDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BelongsToCollection {
  const BelongsToCollection();

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatedBy {
  final int id;
  final String creditId;
  final String profilePath;
  final String name;
  final int gender;
  CreatedBy(
      {required this.id,
      required this.creditId,
      required this.name,
      required this.gender,
      required this.profilePath});

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
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
class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => ProductionCompanyToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;
  ProductionCountry({
    required this.iso,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => ProductionCountryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage {
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;

  SpokenLanguage({
    required this.iso,
    required this.name,
  });
  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}
