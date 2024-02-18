import 'package:bloc/bloc.dart';
import 'package:move_app_1/domain/api_client/tv_show_api_client.dart';
import 'package:move_app_1/domain/blocs/tv_show_recommendations_bloc/tv_show_recommendations_event.dart';
import 'package:move_app_1/domain/blocs/tv_show_recommendations_bloc/tv_show_recommendations_state.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show_recommendations.dart';

class TvShowRecommendationsBloc
    extends Bloc<TvShowRecommendationsEvent, TvShowRecommendationsState> {
  final TvShowApiClient apiClient;

  TvShowRecommendationsBloc({required this.apiClient})
      : super(TvShowRecommendationsInitial()) {
    on<FetchRecommendationsTvShow>(_onFetchRecommendationsTvShow);
  }

  Future<void> _onFetchRecommendationsTvShow(
    FetchRecommendationsTvShow event,
    Emitter<TvShowRecommendationsState> emit,
  ) async {
    emit(TvShowRecommendationsLoading());
    try {
      final List<TvShowRecommendations>? recommendations = await apiClient
          .fetchRecommendationsTvShow(event.tvshowId, event.locale!);

      if (recommendations != null) {
        final List<TvShowRecommendations> tvshowRecs = recommendations;
        emit(TvShowRecommendationsLoaded(
          tvshow: tvshowRecs,
        ));
      } else {
        emit(TvShowRecommendationsError());
      }
    } catch (e) {
      emit(TvShowRecommendationsError());
    }
  }
}
