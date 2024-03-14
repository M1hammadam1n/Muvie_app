import 'package:move_app_1/domain/model_movie/movie.dart';

class TopMovieListContainer {
  final List<Movie> movies;
  final int currentPage;
  final int totalPage;

  bool get isComplete => currentPage >= totalPage;

  const TopMovieListContainer.inital()
      : movies = const <Movie>[],
        currentPage = 0,
        totalPage = 1;

  TopMovieListContainer({
    required this.movies,
    required this.currentPage,
    required this.totalPage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopMovieListContainer &&
          runtimeType == other.runtimeType &&
          movies == other.movies &&
          currentPage == other.currentPage &&
          totalPage == other.totalPage;

  @override
  int get hashCode =>
      movies.hashCode ^ currentPage.hashCode ^ totalPage.hashCode;

  TopMovieListContainer copyWith({
    List<Movie>? movies,
    int? currentPage,
    int? totalPage,
  }) {
    return TopMovieListContainer(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
    );
  }
}

class TopMovieListState {
  final TopMovieListContainer popularMovieContainer;

  List<Movie> get movies =>
      popularMovieContainer.movies;

  const TopMovieListState.inital()
      : popularMovieContainer = const TopMovieListContainer.inital();

  TopMovieListState({
    required this.popularMovieContainer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopMovieListState &&
          runtimeType == other.runtimeType &&
          popularMovieContainer == other.popularMovieContainer;

  @override
  int get hashCode =>
      popularMovieContainer.hashCode;

  TopMovieListState copyWith({
    TopMovieListContainer? popularMovieContainer,
  }) {
    return TopMovieListState(
      popularMovieContainer:
          popularMovieContainer ?? this.popularMovieContainer,
    );
  }


}
