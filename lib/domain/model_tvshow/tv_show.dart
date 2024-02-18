import 'package:json_annotation/json_annotation.dart';

part 'tv_show.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TvShow {
  final bool adult;
  final String? posterPath;
  final List<int>? createdBy;
  final List<int>? episodeRunTime;
  final DateTime? firstAirDate;
  final List<int>? genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final String? lastEpisodeToAir;
  final String name;
  final String? nextEpisodeToAir;
  final List<int>? networks;
  final int? numberOfEpisodes;
  final List<int>? genreIds;
  final int? numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double? popularity;
  final List<String>? productionCompanies;
  final List<String>? productionCountries;
  final List<String>? seasons;
  final List<String>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double voteAverage;
  final int voteCount;


  TvShow({

    required this.adult,
    required this.posterPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.genreIds,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });
factory TvShow.fromJson(Map<String, dynamic> json) {
  final episodeRunTimeJson = json['episode_run_time'];
  final episodeRunTimeList = (episodeRunTimeJson is List) ? List<int>.from(episodeRunTimeJson) : null;

  final networksJson = json['networks'];
  final networksList = (networksJson is List) ? List<int>.from(networksJson) : null;

  final genreIdsJson = json['genre_ids'];

  DateTime? firstAirDate;
  if (json['first_air_date'] != null && json['first_air_date'] is String) {
    try {
      firstAirDate = DateTime.parse(json['first_air_date'] as String);
    } catch (e) {
      print('Error parsing first_air_date: $e');
    }
  }
    return TvShow(
      adult: json['adult'] as bool,
      posterPath: json['poster_path'] as String?,
      createdBy: (json['created_by'] as List?)?.map((e) => e as int).toList(),
      episodeRunTime: episodeRunTimeList,
      firstAirDate: firstAirDate,
      genres: (json['genres'] as List?)?.map((e) => e as int).toList(),
      homepage: json['homepage'] as String?,
      id: json['id'] as int,
      inProduction: json['in_production'] as bool?,
      languages: (json['languages'] as List?)?.map((e) => e as String).toList(),
      lastAirDate: json['last_air_date'] as String?,
      lastEpisodeToAir: json['last_episode_to_air'] as String?,
      name: json['name'] as String,
      nextEpisodeToAir: json['next_episode_to_air'] as String?,
      networks: networksList,
      numberOfEpisodes: json['number_of_episodes'] as int?,
      genreIds: (genreIdsJson is List) ? List<int>.from(genreIdsJson) : [],
      numberOfSeasons: json['number_of_seasons'] as int?,
      originCountry: (json['origin_country'] as List?)!.map((e) => e as String).toList(),
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: json['popularity'] as double?,
      productionCompanies: (json['production_companies'] as List?)?.map((e) => e as String).toList(),
      productionCountries: (json['production_countries'] as List?)?.map((e) => e as String).toList(),
      seasons: (json['seasons'] as List?)?.map((e) => e as String).toList(),
      spokenLanguages: (json['spoken_languages'] as List?)?.map((e) => e as String).toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      type: json['type'] as String?,
      voteAverage: json['vote_average'] as double,
      voteCount: json['vote_count'] as int,
    );
  }

  get releaseDate => null;

  get backdropPath => null;



  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'poster_path': posterPath,
      'created_by': createdBy,
      'episode_run_time': episodeRunTime,
      'first_air_date': firstAirDate?.toIso8601String(),
      'genres': genres,
      'homepage': homepage,
      'id': id,
      'in_production': inProduction,
      'languages': languages,
      'last_air_date': lastAirDate,
      'last_episode_to_air': lastEpisodeToAir,
      'name': name,
      'next_episode_to_air': nextEpisodeToAir,
      'networks': networks,
      'number_of_episodes': numberOfEpisodes,
      'genre_ids': genreIds,
      'number_of_seasons': numberOfSeasons,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'production_companies': productionCompanies,
      'production_countries': productionCountries,
      'seasons': seasons,
      'spoken_languages': spokenLanguages,
      'status': status,
      'tagline': tagline,
      'type': type,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
