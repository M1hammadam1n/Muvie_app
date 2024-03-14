import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/configuration/configuration.dart';
import 'package:move_app_1/domain/api_client/movie_api_client.dart';
import 'package:move_app_1/domain/blocs/news_movie_bloc/news_movie_event.dart';
import 'package:move_app_1/domain/blocs/news_movie_bloc/news_movie_state.dart';
import 'package:move_app_1/domain/model_movie/movie.dart';
import 'package:move_app_1/domain/model_movie/popular_movie_response.dart';

class TopMovieListBloc extends Bloc<TopMovieListEvent, TopMovieListState> {
  final MovieApiClient _movieApiClient = MovieApiClient();

  TopMovieListBloc(
    TopMovieListState initialState,
  ) : super(initialState) {
    on<TopMovieListEvent>((event, emit) async {
      if (event is TopMovieListEventLoadNextPage) {
        await _onTopMovieListEventLoadNextPage(event, emit);
      } else if (event is TopMovieListEventLoadReset) {
        await _onTopMovieListEventLoadReset(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _onTopMovieListEventLoadNextPage(
    TopMovieListEventLoadNextPage event,
    Emitter<TopMovieListState> emit,
  ) async {
    TopMovieListContainer? container;
    container = await _loadNextPage(
      state.popularMovieContainer,
      (nextPage) async {
        final result = await _movieApiClient.topMovie(
          nextPage,
          event.locale,
          Configuration.apiKey,
        );
        return result;
      },
    );
    if (container != null) {
      final newState = state.copyWith(
        popularMovieContainer: container,
      );
      emit(newState);
    }
  }

  Future<TopMovieListContainer?> _loadNextPage(
    TopMovieListContainer container,
    Future<PopularMovieResponse> Function(int) loader,
  ) async {
    if (container.isComplete) return null;
    final nextPage = container.currentPage + 1;
    final result = await loader(nextPage);
    final movies = List<Movie>.from(container.movies)..addAll(result.movies);
    final newContainer = container.copyWith(
      movies: movies,
      currentPage: result.page,
      totalPage: result.totalPages,
    );
    return newContainer;
  }

  Future<void> _onTopMovieListEventLoadReset(
    TopMovieListEventLoadReset event,
    Emitter<TopMovieListState> emit,
  ) async {
    emit(const TopMovieListState.inital());
  }
}
