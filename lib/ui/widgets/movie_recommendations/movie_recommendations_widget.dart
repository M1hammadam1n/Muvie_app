import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/image_client.dart';
import 'package:move_app_1/domain/api_client/movie_api_client.dart';
import 'package:move_app_1/domain/blocs/movie_recommendations_bloc/movie_recommendations_bloc.dart';
import 'package:move_app_1/domain/blocs/movie_recommendations_bloc/movie_recommendations_event.dart';
import 'package:move_app_1/domain/blocs/movie_recommendations_bloc/movie_recommendations_state.dart';
import 'package:move_app_1/ui/navigation/navigation.dart';

class RecommendedMovie extends StatelessWidget {
  const RecommendedMovie({Key? key, required this.movieId}) : super(key: key);
  final int movieId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieRecommendationsBloc>(
      create: (context) => MovieRecommendationsBloc(apiClient: MovieApiClient())
        ..add(FetchRecommendationsMovie(movieId: movieId, locale: 'ru-Ru')),
      child: const SizedBox(
        height: 250,
        child: Scrollbar(
          child: RecommendedMovieWidget(),
        ),
      ),
    );
  }
}

class RecommendedMovieWidget extends StatelessWidget {
  const RecommendedMovieWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieRecommendationsBloc, MovieRecommendationsState>(
      builder: (context, state) {
        if (state is MovieRecommendationsLoading) {
        } else if (state is MovieRecommendationsLoaded) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 120,
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _onMovieTap(context, movie.id),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              Container(
                                child: ImageDownloader.cachedNetworkImage(
                                  movie.posterPath.toString(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title.toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      movie.overview.toString(),
                                      style: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onMovieTap(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.movieDetails,
        arguments: movieId,
      );
    }
  }
}
