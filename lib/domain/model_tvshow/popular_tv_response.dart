import 'package:json_annotation/json_annotation.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show.dart';


part 'popular_tv_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularTvResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<TvShow> tvShows;
  final int totalResults;
  final int totalPages;

  PopularTvResponse({
    required this.page,
    required this.totalResults,
    required this.tvShows,
    required this.totalPages,
  });

  factory PopularTvResponse.fromJson(Map<String, dynamic> json) {
    final tvShowsJson = json['results'] as List<dynamic>?;
    final tvShowsList = tvShowsJson?.map((e) => TvShow.fromJson(e)).toList() ?? [];

    return PopularTvResponse(
      page: json['page'] as int,
      totalResults: json['total_results'] as int,
      tvShows: tvShowsList,
      totalPages: json['total_pages'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'results': tvShows.map((e) => e.toJson()).toList(),
        'total_results': totalResults,
        'total_pages': totalPages,
      };
}
