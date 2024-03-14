import 'package:move_app_1/configuration/configuration.dart';
import 'package:move_app_1/domain/api_client/network_client.dart';
import 'package:move_app_1/domain/model_movie/movie_details.dart';
import 'package:move_app_1/domain/model_movie/movie_details_credits.dart';
import 'package:move_app_1/domain/model_movie/movie_recommended.dart';
import 'package:move_app_1/domain/model_movie/popular_movie_response.dart';

class MovieApiClient {
  final _networkClient = NetworkClient();

  Future<PopularMovieResponse> popularMovie(
    int page,
    String locale,
    String apiKey,
    ) async {
    PopularMovieResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> topMovie(
    int page,
    String locale,
    String apiKey,
    ) async {
    PopularMovieResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/movie/top_rated',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<MovieDetails> movieDetails(
    int movieId,
    String locale,
  ) async {
    MovieDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/movie/$movieId',
      parser,
      <String, dynamic>{
        'append_to_response': 'credits,videos',
        'api_key': Configuration.apiKey,
        'language': locale,
      },
    );
    return result;
  }


Future<List<Actor>?> movieDetailsCredits(
  int movieId,
  String locale,
) async {
  List<Actor>? parser(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    if (jsonMap.containsKey('cast') && jsonMap['cast'] != null) {
      final List<Actor> response = [];
      for (var movie in jsonMap['cast']) {
        response.add(Actor.fromJson(movie));
      }
      if (response.isEmpty) return null;
      return response;
    } else {
      return null;
    }
  }

  final result = await _networkClient.get(
    '/movie/$movieId/credits',
    parser,
    <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': locale,
    },
  );

  return result;
}

  Future<List<MovieRecommendations>?> fetchRecommendationsMovie(
    int movieId,
    String locale,
  ) async {
    List<MovieRecommendations>? parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;

      final List<MovieRecommendations> response = [];
      for (var movie in jsonMap['results']) {
        response.add(MovieRecommendations.fromJson(movie));
      }
      if (response.isEmpty) return null;
      return response;
    }

    final result = await _networkClient.get(
      '/movie/$movieId/recommendations',
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
