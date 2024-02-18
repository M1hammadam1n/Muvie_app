import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/configuration/configuration.dart';
import 'package:move_app_1/domain/api_client/movie_api_client.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_event.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_state.dart';
import 'package:move_app_1/domain/model_movie/movie.dart';
import 'package:move_app_1/domain/model_movie/popular_movie_response.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieApiClient _movieApiClient = MovieApiClient();

  MovieListBloc(
    MovieListState initialState,
  ) : super(initialState) {
    on<MovieListEvent>((event, emit) async {
      if (event is MovieListEventLoadNextPage) {
        await _onMovieListEventLoadNextPage(event, emit);
      } else if (event is MovieListEventLoadReset) {
        await _onMovieListEventLoadReset(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _onMovieListEventLoadNextPage(
    MovieListEventLoadNextPage event,
    Emitter<MovieListState> emit,
  ) async {
    MovieListContainer? container;
    container = await _loadNextPage(
      state.popularMovieContainer,
      (nextPage) async {
        final result = await _movieApiClient.popularMovie(
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

  Future<MovieListContainer?> _loadNextPage(
    MovieListContainer container,
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

  Future<void> _onMovieListEventLoadReset(
    MovieListEventLoadReset event,
    Emitter<MovieListState> emit,
  ) async {
    emit(const MovieListState.inital());
  }
}
