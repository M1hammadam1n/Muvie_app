import 'package:bloc/bloc.dart';
import 'package:move_app_1/domain/api_client/movie_api_client.dart';
import 'package:move_app_1/domain/blocs/movie_recommendations_bloc/movie_recommendations_event.dart';
import 'package:move_app_1/domain/blocs/movie_recommendations_bloc/movie_recommendations_state.dart';
import 'package:move_app_1/domain/model_movie/movie_recommended.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final MovieApiClient apiClient;

  MovieRecommendationsBloc({required this.apiClient})
      : super(MovieRecommendationsInitial()) {
    on<FetchRecommendationsMovie>(_onFetchRecommendationsMovie);
  }

  Future<void> _onFetchRecommendationsMovie(
    FetchRecommendationsMovie event,
    Emitter<MovieRecommendationsState> emit,
  ) async {
    emit(MovieRecommendationsLoading());
    try {
      final List<MovieRecommendations>? recommendations = await apiClient
          .fetchRecommendationsMovie(event.movieId, event.locale!);
      if (recommendations != null) {
        final List<MovieRecommendations> movieRecs = recommendations;
        emit(MovieRecommendationsLoaded(
          movies: movieRecs,
        ));
      } else {
        emit(MovieRecommendationsError());
      }
    } catch (e) {
      emit(MovieRecommendationsError());
    }
  }
}
