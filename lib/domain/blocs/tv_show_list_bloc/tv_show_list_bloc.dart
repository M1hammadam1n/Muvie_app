import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/configuration/configuration.dart';
import 'package:move_app_1/domain/api_client/tv_show_api_client.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_event.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_state.dart';
import 'package:move_app_1/domain/model_tvshow/popular_tv_response.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show.dart';

class TvShowListBloc extends Bloc<TvShowListEvent, TvShowListState> {
  final TvShowApiClient _tvshowApiClient = TvShowApiClient();

  TvShowListBloc(
    TvShowListState initialState,
  ) : super(initialState) {
    on<TvShowListEvent>((event, emit) async {
      if (event is TvShowListEventLoadNextPage) {
        await onTvShowListEventLoadNextPage(event, emit);
      } else if (event is TvShowListEventLoadReset) {
        await onTvShowListEventLoadReset(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> onTvShowListEventLoadNextPage(
    TvShowListEventLoadNextPage event,
    Emitter<TvShowListState> emit,
  ) async {
    TvShowListContainer? container;
    container = await _loadNextPage(
      state.popularTvShowContainer,
      (nextPage) async {
        final result = await _tvshowApiClient.popularTv(
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

  Future<TvShowListContainer?> _loadNextPage(
    TvShowListContainer container,
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

  Future<void> onTvShowListEventLoadReset(
    TvShowListEventLoadReset event,
    Emitter<TvShowListState> emit,
  ) async {
    emit(const TvShowListState.inital());
  }
}
