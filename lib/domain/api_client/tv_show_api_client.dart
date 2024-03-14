import 'package:move_app_1/configuration/configuration.dart';
import 'package:move_app_1/domain/api_client/network_client.dart';
import 'package:move_app_1/domain/model_tvshow/popular_tv_response.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show_details.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show_recommendations.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show_details_credits.dart';

class TvShowApiClient {
  final _networkClient = NetworkClient();

  Future<PopularTvResponse> popularTv(
    int page,
    String locale,
    String apiKey,
  ) async {
    PopularTvResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularTvResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/tv/popular',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );

    return result;
  }

    Future<PopularTvResponse> TopTv(
    int page,
    String locale,
    String apiKey,
  ) async {
    PopularTvResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularTvResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/tv/top_rated',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );

    return result;
  }


  Future<TvShowDetails> tvShowDetails(
    int tvShowId,
    String locale,
  ) async {
    TvShowDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = TvShowDetails.fromJson(jsonMap);
      return response;
    }

    final result = await _networkClient.get(
      '/tv/$tvShowId',
      parser,
      <String, dynamic>{
        'append_to_response': 'credits,videos',
        'api_key': Configuration.apiKey,
        'language': locale,
      },
    );
  
    return result;
  }


Future<List<Actors>?> tvShowDetailsCredits(
  int tvShowId,
  String locale,
) async {
  List<Actors>? parser(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    if (jsonMap.containsKey('cast') && jsonMap['cast'] != null) {
      final List<Actors> response = [];
      for (var tvshow in jsonMap['cast']) {
        response.add(Actors.fromJson(tvshow));
      }
      if (response.isEmpty) return null;
      return response;
    } else {
      return null;
    }
  }

  final result = await _networkClient.get(
    '/tv/$tvShowId/credits',
    parser,
    <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': locale,
    },
  );

  return result;
}



  Future<List<TvShowRecommendations>?> fetchRecommendationsTvShow(
    int tvshowId,
    String locale,
  ) async {
    List<TvShowRecommendations>? parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;

      final List<TvShowRecommendations> response = [];
      for (var tvshow in jsonMap['results']) {
        response.add(TvShowRecommendations.fromJson(tvshow));
      }
      if (response.isEmpty) return null;
      return response;
    }

    final result = await _networkClient.get(
      '/tv/$tvshowId/recommendations',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'language': locale,
        'page': '1',
      },
    );
    return result;
  }
}
