import 'package:move_app_1/configuration/configuration.dart';
import 'package:move_app_1/domain/api_client/network_client.dart';

enum MediaType { movie,  tvShow }
extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tvShow:
        return 'tvshow';
    }
  }
}


class AccountApiClient{
   final _networkClient = NetworkClient();

   
     Future<int> getAccountInfo(
    String sessionId,
  ) async {
    int parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final result = _networkClient.get(
      '/account',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
   
   Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
  }) async {
    int parser(dynamic json) {
      return 1;
    }

    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
    };
    final result = _networkClient.post(
      '/account/$accountId/favorite',
      parameters,
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
  
}