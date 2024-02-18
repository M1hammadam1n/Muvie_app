abstract class MovieDetailsEvent {
  const MovieDetailsEvent();
}

class FetchMovieDetails extends MovieDetailsEvent {
  final int movieId;
  final String locale;

  const FetchMovieDetails({required this.movieId, required this.locale});
}
