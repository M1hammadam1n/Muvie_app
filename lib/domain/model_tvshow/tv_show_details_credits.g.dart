// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_details_credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowDetailsCredits _$TvShowDetailsCreditsFromJson(
        Map<String, dynamic> json) =>
    TvShowDetailsCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Actors.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvShowDetailsCreditsToJson(
        TvShowDetailsCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
    };

Actors _$ActorsFromJson(Map<String, dynamic> json) => Actors(
      adult: json['adult'] as bool?,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String,
      castId: json['cast_id'] as int?,
      character: json['character'] as String,
      creditId: json['credit_id'] as String?,
      order: json['order'] as int?,
    );

Map<String, dynamic> _$ActorsToJson(Actors instance) => <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'cast_id': instance.castId,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      adult: json['adult'] as bool,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String?,
      department: json['department'] as String,
      job: json['job'] as String,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'credit_id': instance.creditId,
      'department': instance.department,
      'job': instance.job,
    };
