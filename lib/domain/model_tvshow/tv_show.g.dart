// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShow _$TvShowFromJson(Map<String, dynamic> json) => TvShow(
      adult: json['adult'] as bool,
      posterPath: json['poster_path'] as String?,
      createdBy:
          (json['created_by'] as List<dynamic>?)?.map((e) => e as int).toList(),
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      firstAirDate: json['first_air_date'] == null
          ? null
          : DateTime.parse(json['first_air_date'] as String),
      genres: (json['genres'] as List<dynamic>?)?.map((e) => e as int).toList(),
      homepage: json['homepage'] as String?,
      id: json['id'] as int,
      inProduction: json['in_production'] as bool?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastAirDate: json['last_air_date'] as String?,
      lastEpisodeToAir: json['last_episode_to_air'] as String?,
      name: json['name'] as String,
      nextEpisodeToAir: json['next_episode_to_air'] as String?,
      networks:
          (json['networks'] as List<dynamic>?)?.map((e) => e as int).toList(),
      numberOfEpisodes: json['number_of_episodes'] as int?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      numberOfSeasons: json['number_of_seasons'] as int?,
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num?)?.toDouble(),
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      seasons:
          (json['seasons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      type: json['type'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$TvShowToJson(TvShow instance) => <String, dynamic>{
      'adult': instance.adult,
      'poster_path': instance.posterPath,
      'created_by': instance.createdBy,
      'episode_run_time': instance.episodeRunTime,
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'genres': instance.genres,
      'homepage': instance.homepage,
      'id': instance.id,
      'in_production': instance.inProduction,
      'languages': instance.languages,
      'last_air_date': instance.lastAirDate,
      'last_episode_to_air': instance.lastEpisodeToAir,
      'name': instance.name,
      'next_episode_to_air': instance.nextEpisodeToAir,
      'networks': instance.networks,
      'number_of_episodes': instance.numberOfEpisodes,
      'genre_ids': instance.genreIds,
      'number_of_seasons': instance.numberOfSeasons,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'production_companies': instance.productionCompanies,
      'production_countries': instance.productionCountries,
      'seasons': instance.seasons,
      'spoken_languages': instance.spokenLanguages,
      'status': instance.status,
      'tagline': instance.tagline,
      'type': instance.type,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
