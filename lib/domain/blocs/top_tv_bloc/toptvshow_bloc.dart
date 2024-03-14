import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/configuration/configuration.dart';
import 'package:move_app_1/domain/api_client/tv_show_api_client.dart';
import 'package:move_app_1/domain/blocs/top_tv_bloc/toptvshow_event.dart';
import 'package:move_app_1/domain/blocs/top_tv_bloc/toptvshow_state.dart';
import 'package:move_app_1/domain/model_tvshow/popular_tv_response.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show.dart';

class TopTvShowListBloc extends Bloc<TopTvShowListEvent, TopTvShowListState> {
  final TvShowApiClient _tvshowApiClient = TvShowApiClient();

  TopTvShowListBloc(
    TopTvShowListState initialState,
  ) : super(initialState) {
    on<TopTvShowListEvent>((event, emit) async {
      if (event is TopTvShowListEventLoadNextPage) {
        await onTopTvShowListEventLoadNextPage(event, emit);
      } else if (event is TopTvShowListEventLoadReset) {
        await onTopTvShowListEventLoadReset(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> onTopTvShowListEventLoadNextPage(
    TopTvShowListEventLoadNextPage event,
    Emitter<TopTvShowListState> emit,
  ) async {
    TopTvShowListContainer? container;
    container = await _loadNextPage(
      state.popularTvShowContainer,
      (nextPage) async {
        final result = await _tvshowApiClient.TopTv(
          nextPage,
          event.locale,
          Configuration.apiKey,
        );
        return result;
      },
    );
    if (container != null) {
      final newState = state.copyWith(
        popularTvShowContainer: container,
      );
      emit(newState);
    }
  }

  Future<TopTvShowListContainer?> _loadNextPage(
    TopTvShowListContainer container,
    Future<PopularTvResponse> Function(int) loader,
  ) async {
    if (container.isComplete) return null;
    final nextPage = container.currentPage + 1;
    final result = await loader(nextPage);
    final tvShows = List<TvShow>.from(container.tvshow)..addAll(result.tvShows);
    final newContainer = container.copyWith(
      tvshow: tvShows,
      currentPage: result.page,
      totalPage: result.totalPages,
    );
    return newContainer;
  }

  Future<void> onTopTvShowListEventLoadReset(
    TopTvShowListEventLoadReset event,
    Emitter<TopTvShowListState> emit,
  ) async {
    emit(const TopTvShowListState.inital());
  }
}
