import 'package:bloc/bloc.dart';
import 'package:move_app_1/domain/api_client/movie_api_client.dart';
import 'package:move_app_1/domain/blocs/movie_details/movie_details_event.dart';
import 'package:move_app_1/domain/blocs/movie_details/movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieApiClient apiClient;

  MovieDetailsBloc({required this.apiClient}) : super(MovieDetailsInitial()) {
    on<FetchMovieDetails>(_onFetchMovieDetails);
  }

 Future<void> _onFetchMovieDetails(
  FetchMovieDetails event,
  Emitter<MovieDetailsState> emit,
) async {
  emit(MovieDetailsLoading());
  try {
    final movieDetails = await apiClient.movieDetails(event.movieId, event.locale);
    final actorData = await apiClient.movieDetailsCredits(event.movieId, event.locale);

    emit(MovieDetailsLoaded(movieDetails: movieDetails, actorData: actorData ?? []));
  } catch (e) {
    emit(MovieDetailsError());
  }
}

}
