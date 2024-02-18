import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:move_app_1/domain/api_client/image_client.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_bloc.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_event.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_state.dart';
import 'package:move_app_1/domain/model_movie/movie.dart';
import 'package:move_app_1/ui/navigation/navigation.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return BlocProvider(
      create: (_) => MovieListBloc(const MovieListState.inital())
        ..add(MovieListEventLoadReset())
        ..add(MovieListEventLoadNextPage(locale.languageCode)),
      child: const _MovieListWidget(),
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          itemCount: state.movies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            if (index >= state.movies.length - 1) {
              final locale = Localizations.localeOf(context).languageCode;
              context
                  .read<MovieListBloc>()
                  .add(MovieListEventLoadNextPage(locale));
            }
            final movie = state.movies[index];
            return _MovieListRowWidget(movie: movie);
          },
        );
      },
    );
  }
}

class _MovieListRowWidget extends StatelessWidget {
  final Movie movie;

  const _MovieListRowWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.black.withOpacity(0.15),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                if (posterPath != null)
                  ImageDownloader.cachedNetworkImage(posterPath,
                      fit: BoxFit.cover),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        formatDate(movie.releaseDate),
                        style: const TextStyle(color: Colors.white30),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _onMovieTap(context, movie.id),
            ),
          ),
        ],
      ),
    );
  }

  void _onMovieTap(BuildContext context, int movieId) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: movieId,
    );
  }
}

String formatDate(DateTime? date) {
  if (date != null) {
    final dateFormat = DateFormat.yMMMMd();
    return dateFormat.format(date);
  }
  return '';
}
