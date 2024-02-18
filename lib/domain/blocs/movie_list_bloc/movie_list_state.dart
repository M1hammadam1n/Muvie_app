
import 'package:move_app_1/domain/model_movie/movie.dart';

class MovieListContainer {
  final List<Movie> movies;
  final int currentPage;
  final int totalPage;

  bool get isComplete => currentPage >= totalPage;

  const MovieListContainer.inital()
      : movies = const <Movie>[],
        currentPage = 0,
        totalPage = 1;

  MovieListContainer({
    required this.movies,
    required this.currentPage,
    required this.totalPage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieListContainer &&
          runtimeType == other.runtimeType &&
          movies == other.movies &&
          currentPage == other.currentPage &&
          totalPage == other.totalPage;

  @override
  int get hashCode =>
      movies.hashCode ^ currentPage.hashCode ^ totalPage.hashCode;

  MovieListContainer copyWith({
    List<Movie>? movies,
    int? currentPage,
    int? totalPage,
  }) {
    return MovieListContainer(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
    );
  }
}

class MovieListState {
  final MovieListContainer popularMovieContainer;

  List<Movie> get movies =>
      popularMovieContainer.movies;

  const MovieListState.inital()
      : popularMovieContainer = const MovieListContainer.inital();

  MovieListState({
    required this.popularMovieContainer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieListState &&
          runtimeType == other.runtimeType &&
          popularMovieContainer == other.popularMovieContainer;

  @override
  int get hashCode =>
      popularMovieContainer.hashCode;

  MovieListState copyWith({
    MovieListContainer? popularMovieContainer,
  }) {
    return MovieListState(
      popularMovieContainer:
          popularMovieContainer ?? this.popularMovieContainer,
    );
  }
}
