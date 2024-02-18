import 'package:json_annotation/json_annotation.dart';

part 'tv_show_details_credits.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowDetailsCredits {
  final List<Actors> cast;
  final List<Employee> crew;
  TvShowDetailsCredits({
    required this.cast,
    required this.crew,
  });

  factory TvShowDetailsCredits.fromJson(Map<String, dynamic> json) =>
      _$TvShowDetailsCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowDetailsCreditsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Actors {
  final bool? adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int? castId;
  final String character;
  final String? creditId;
  final int? order;
  Actors({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Actors.fromJson(Map<String, dynamic> json) => _$ActorsFromJson(json);
  Map<String, dynamic> toJson() => _$ActorsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Employee {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String? creditId;
  final String department;
  final String job;
  Employee({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
